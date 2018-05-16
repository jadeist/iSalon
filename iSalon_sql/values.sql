use iSalon;

delete from catgrupousuario;
delete from cathorariogrupo;
delete from cathorariosalon;
delete from catMenuContent;
delete from menuContent;
delete from usuarios;
delete from salones;
delete from grupos;
delete from horarios;

insert into usuarios(id, username, name, pass, tipo) values
(10, 'laxelott', 'Axel Treviño', 1510372, 3)
;

insert into menuContent(id, name, icon, link, target, priority, active) values
(0, 'Inicio', 'home', 'cuenta/inicio.jsp', 'content', 5, 1),
(1, 'Logout', 'exit_to_app', 'cuenta/logout.jsp', '_self', 0, 1),
(2, 'Usuarios', 'person', 'admin/usuarios/', 'content', 3, 1),
(3, 'Modificar Cuenta', 'settings', 'cuenta/cambios/', 'content', 1, 1),
(4, 'Horarios', 'border_all', 'horarios/', 'content', 2, 1),
(5, 'Grupos', 'group', 'admin/grupos/', 'content', 3, 1)
;

insert into catMenuContent(idMenu, typeUsr) values
# Inicio
(0, 0),
(0, 1),
(0, 2),
(0, 3),
# Logout
(1, 0),
(1, 1),
(1, 2),
(1, 3),
# Usuarios
(2, 3),
# Modificar Cuenta
(3, 0),
(3, 1),
(3, 2),
(3, 3),
# Horarios
(4, 0),
(4, 1),
(4, 2),
(4, 3),
# Grupos
(5, 3)
;

insert into salones(id, nombre) values
(1, 'Salon 1');

insert into grupos(id, nombre) values
(1, '5IV6');

insert into horarios(id, nombre, horaInicio, horaFinal, dia) values
(1, 'Fisica', 0, 2, 0),
(2, 'Fisica', 1, 3, 1),
(3, 'Fisica', 2, 4, 2),
(4, 'Fisica', 3, 5, 3),
(5, 'Fisica', 4, 6, 4),
(6, 'Integral', 5, 6, 2)
;

insert into catgrupousuario(idUsr, idGrp) values
(10, 1);

insert into cathorariogrupo(idHor, idGrp) values
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1)
;

insert into catHorarioSalon(idHor, idSal) values
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1)
;