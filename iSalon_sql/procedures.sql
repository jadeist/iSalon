drop procedure if exists agregarClase;

delimiter **
create procedure agregarClase(in n nvarchar(250))
begin

	## Código...

end ; **
delimiter ;


drop procedure if exists crearGrupo;

delimiter **
create procedure crearGrupo(in n nvarchar(250))
begin 

	declare isValid int;
	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from grupos where id = i);
	
	if num = 0 then
		insert into grupo(nombre)
			values (n);
	
		set message = "Usuario creado!";
		set num = (select id from grupos where id = i);
		set isValid = 1;
	else 
		set message = "Usuario ya existe!";
		set num = -1;
		set isValid = 0;
	end if;
	
	select message, num as id, isValid;

end ; **
delimiter ;
