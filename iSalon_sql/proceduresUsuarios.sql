drop procedure if exists validarUsuario;

delimiter **
create procedure validarUsuario(in u nvarchar(250), in p int)
begin 

	declare num int;
	declare name nvarchar(250);
	declare isValid int;
	declare tipo int;
	
	set isValid = 0;
	set num = (select count(*) from usuarios where username = u and pass = p);
	
	if num = 0 then
		set name = "";
		set isValid = 0;
		set num = -1;
		set tipo = 0;
	else 
		set isValid = 1;
		set name = (select name from usuarios where username = u and pass = p);
		set num = (select id from usuarios where username = u and pass = p);
		set tipo = (select tipo from usuarios where username = u and pass = p);
	end if;
	
	select num as id, isValid, tipo, name;

end ; **
delimiter ;


drop procedure if exists crearUsuario;

delimiter **
create procedure crearUsuario(in u nvarchar(250), in n nvarchar(250), in p int, in t int)
begin 

	declare isValid int;
	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from usuarios
		where username = u
		and name = n
		and pass = p
		and tipo = t
	);
	
	if num = 0 then
		insert into usuarios(username, name, pass, tipo)
			values (u, n, p, t);
	
		set message = "Usuario creado!";
		set num = (select id from usuarios
			where username = u
			and name = n
			and pass = p
			and tipo = t
		);
		set isValid = 1;
	else 
		set message = "Usuario ya existe!";
		set num = -1;
		set isValid = 0;
	end if;
	
	select message, num as id, isValid;

end ; **
delimiter ;


drop procedure if exists editarUsuario;

delimiter **
create procedure editarUsuario(in u nvarchar(250), in n nvarchar(250), in p int, in i int)
begin 

	declare isValid int;
	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from usuarios where id = i);
	
	if num = 0 then
		set message = "Usuario no existe!";
		set isValid = 0;
	else
		if p = -1 then
			set p = (select pass from usuarios where id = i);
		end if;
	
		update usuarios
			set name = n,
			username = u,
			pass = p
			where id = i;
			
	
		set message = "Usuario modificado!";
		set isValid = 1;
	end if;
	
	select message, isValid;

end ; **
delimiter ;


drop procedure if exists eliminarUsuario;

delimiter **
create procedure eliminarUsuario(in i int)
begin 

	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from usuarios where id = i);
	
	if num = 0 then
		set message = "Usuario no existe!";
		set num = 0;
	else
		delete from usuarios where id = i;
	
		set message = "Usuario eliminado!";
		set num = 1;
	end if;
	
	select message, num as isValid;

end ; **
delimiter ;