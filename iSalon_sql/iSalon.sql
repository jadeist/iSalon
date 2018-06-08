-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.30-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para isalon
DROP DATABASE IF EXISTS `isalon`;
CREATE DATABASE IF NOT EXISTS `isalon` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `isalon`;

-- Volcando estructura para procedimiento isalon.agregarClase
DROP PROCEDURE IF EXISTS `agregarClase`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarClase`(in n nvarchar(250))
begin

	## Código...

end//
DELIMITER ;

-- Volcando estructura para tabla isalon.catgrupousuario
DROP TABLE IF EXISTS `catgrupousuario`;
CREATE TABLE IF NOT EXISTS `catgrupousuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsr` int(11) NOT NULL,
  `idGrp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsr` (`idUsr`),
  KEY `idGrp` (`idGrp`),
  CONSTRAINT `catgrupousuario_ibfk_1` FOREIGN KEY (`idUsr`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `catgrupousuario_ibfk_2` FOREIGN KEY (`idGrp`) REFERENCES `grupos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.catgrupousuario: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `catgrupousuario` DISABLE KEYS */;
INSERT INTO `catgrupousuario` (`id`, `idUsr`, `idGrp`) VALUES
	(2, 10, 1);
/*!40000 ALTER TABLE `catgrupousuario` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.cathorariogrupo
DROP TABLE IF EXISTS `cathorariogrupo`;
CREATE TABLE IF NOT EXISTS `cathorariogrupo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idHor` int(11) NOT NULL,
  `idGrp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idHor` (`idHor`),
  KEY `idGrp` (`idGrp`),
  CONSTRAINT `cathorariogrupo_ibfk_1` FOREIGN KEY (`idHor`) REFERENCES `horarios` (`id`),
  CONSTRAINT `cathorariogrupo_ibfk_2` FOREIGN KEY (`idGrp`) REFERENCES `grupos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.cathorariogrupo: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `cathorariogrupo` DISABLE KEYS */;
INSERT INTO `cathorariogrupo` (`id`, `idHor`, `idGrp`) VALUES
	(13, 1, 1),
	(14, 2, 1),
	(15, 3, 1),
	(16, 4, 1),
	(17, 5, 1),
	(18, 6, 1);
/*!40000 ALTER TABLE `cathorariogrupo` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.cathorariosalon
DROP TABLE IF EXISTS `cathorariosalon`;
CREATE TABLE IF NOT EXISTS `cathorariosalon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idHor` int(11) NOT NULL,
  `idSal` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idHor` (`idHor`),
  KEY `idSal` (`idSal`),
  CONSTRAINT `cathorariosalon_ibfk_1` FOREIGN KEY (`idHor`) REFERENCES `horarios` (`id`),
  CONSTRAINT `cathorariosalon_ibfk_2` FOREIGN KEY (`idSal`) REFERENCES `salones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.cathorariosalon: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `cathorariosalon` DISABLE KEYS */;
INSERT INTO `cathorariosalon` (`id`, `idHor`, `idSal`) VALUES
	(13, 1, 1),
	(14, 2, 1),
	(15, 3, 1),
	(16, 4, 1),
	(17, 5, 1),
	(18, 6, 1);
/*!40000 ALTER TABLE `cathorariosalon` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.catmenucontent
DROP TABLE IF EXISTS `catmenucontent`;
CREATE TABLE IF NOT EXISTS `catmenucontent` (
  `idRelMenuUsr` int(11) NOT NULL AUTO_INCREMENT,
  `idMenu` int(11) NOT NULL,
  `typeUsr` int(11) NOT NULL,
  PRIMARY KEY (`idRelMenuUsr`),
  KEY `idMenu` (`idMenu`),
  CONSTRAINT `catmenucontent_ibfk_1` FOREIGN KEY (`idMenu`) REFERENCES `menucontent` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.catmenucontent: ~23 rows (aproximadamente)
/*!40000 ALTER TABLE `catmenucontent` DISABLE KEYS */;
INSERT INTO `catmenucontent` (`idRelMenuUsr`, `idMenu`, `typeUsr`) VALUES
	(63, 0, 0),
	(64, 0, 1),
	(65, 0, 2),
	(66, 0, 3),
	(67, 1, 0),
	(68, 1, 1),
	(69, 1, 2),
	(70, 1, 3),
	(71, 2, 3),
	(72, 3, 0),
	(73, 3, 1),
	(74, 3, 2),
	(75, 3, 3),
	(76, 4, 0),
	(77, 4, 1),
	(78, 4, 2),
	(79, 4, 3),
	(80, 5, 3),
	(81, 6, 0),
	(82, 6, 1),
	(83, 6, 2),
	(84, 6, 3),
	(85, 7, 3),
	(86, 8, 3);
/*!40000 ALTER TABLE `catmenucontent` ENABLE KEYS */;

-- Volcando estructura para procedimiento isalon.crearGrupo
DROP PROCEDURE IF EXISTS `crearGrupo`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearGrupo`(
	IN `n` nvarchar(250)

,
	IN `t` INT,
	IN `p` INT
)
begin 

	declare isValid int;
	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from grupos where nombre = n
			and turno = t
			and periodo = p);
	
	if num = 0 then
		insert into grupos(nombre, turno, periodo)
			values (n, t, p);
	
		set message = "Grupo creado!";
		set num = (select count(*) from grupos where nombre = n
			and turno = t
			and periodo = p);
			
		set isValid = 1;
	else 
		set message = "Grupo ya existe!";
		set num = -1;
		set isValid = 0;
	end if;
	
	select message, num as id, isValid;

end//
DELIMITER ;

-- Volcando estructura para procedimiento isalon.crearUsuario
DROP PROCEDURE IF EXISTS `crearUsuario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearUsuario`(in u nvarchar(250), in n nvarchar(250), in p int, in t int)
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

end//
DELIMITER ;

-- Volcando estructura para procedimiento isalon.editarUsuario
DROP PROCEDURE IF EXISTS `editarUsuario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `editarUsuario`(in u nvarchar(250), in n nvarchar(250), in p int, in i int)
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

end//
DELIMITER ;

-- Volcando estructura para procedimiento isalon.eliminarUsuario
DROP PROCEDURE IF EXISTS `eliminarUsuario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario`(
	IN `i` int
)
begin 

	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from usuarios where id = i);
	
	if num = 0 then
		set message = "Usuario no existe!";
		set num = 0;
	else
		delete from catgrupousuario where idUsr = i;
		delete from usuarios where id = i;
	
		set message = "Usuario eliminado!";
		set num = 1;
	end if;
	
	select message, num as isValid;

end//
DELIMITER ;

-- Volcando estructura para procedimiento isalon.getTipos
DROP PROCEDURE IF EXISTS `getTipos`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTipos`()
begin

	declare num int;
	
	set num = (select count(*) from tipousuario);
	
	select num, id, nombre from tipousuario order by tipousuario.id asc;

end//
DELIMITER ;

-- Volcando estructura para tabla isalon.grupohorarios
DROP TABLE IF EXISTS `grupohorarios`;
CREATE TABLE IF NOT EXISTS `grupohorarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '#000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.grupohorarios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `grupohorarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupohorarios` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.grupos
DROP TABLE IF EXISTS `grupos`;
CREATE TABLE IF NOT EXISTS `grupos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) CHARACTER SET utf8 NOT NULL,
  `periodo` int(11) NOT NULL DEFAULT '0',
  `turno` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.grupos: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` (`id`, `nombre`, `periodo`, `turno`) VALUES
	(1, '5IV6', 0, 0),
	(2, 'Prueba', 1, 0),
	(3, '1IV5', 2, 1),
	(4, '1IM1', 0, 0);
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.horarios
DROP TABLE IF EXISTS `horarios`;
CREATE TABLE IF NOT EXISTS `horarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT 'SIN ASIGNAR',
  `horaInicio` int(11) NOT NULL,
  `horaFinal` int(11) NOT NULL,
  `dia` int(11) NOT NULL DEFAULT '0',
  `color` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '#000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.horarios: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` (`id`, `nombre`, `horaInicio`, `horaFinal`, `dia`, `color`) VALUES
	(1, 'Fisica', 0, 2, 0, '#000000'),
	(2, 'Fisica', 1, 3, 1, '#000000'),
	(3, 'Fisica', 2, 4, 2, '#000000'),
	(4, 'Fisica', 3, 5, 3, '#000000'),
	(5, 'Fisica', 4, 6, 4, '#000000'),
	(6, 'Integral', 5, 6, 2, '#000000');
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;

-- Volcando estructura para procedimiento isalon.insertarHorario
DROP PROCEDURE IF EXISTS `insertarHorario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarHorario`(
	IN `g` int,
	IN `hi` int,
	IN `hf` int,
	IN `m` int,
	IN `d` int
,
	IN `s` INT
)
    COMMENT 'grupo, horaInicio, horaFinal, Materia, Dia, Salon'
begin

	declare num int;
	declare message nvarchar(250);
	
	set num = (
		select count(*) from horarios
			inner join cathorariogrupo on horarios.id = cathorariogrupo.idHor
			inner join cat
			
		where cathorariogrupo.idGrp = g
		and horarios.horaInicio = hi
		and horarios.horaFinal = hf
		and horarios.nombre = m
		and horarios.dia = d
	);
	
	if num = 0 then
		insert into horarios(horaInicio, horaFinal, nombre, dia) values
		(hi, hf, m, d);
		set num = (select id from horarios
			where horarios.horaInicio = hi
			and horarios.horaFinal = hf
			and horarios.dia = d
			and horarios.nombre = m);
		
		insert into cathorariogrupo(idHor, idGrp) values
		(num, g);
		insert into cathorariosalon(idHor, idSal) values
		(num, s);
		
		set message = 'Materia registrada';
		
	else 
		set message = 'Materia ya existe!';
		set num = -1;
	end if;
	
	select message, num as id;
end//
DELIMITER ;

-- Volcando estructura para tabla isalon.materias
DROP TABLE IF EXISTS `materias`;
CREATE TABLE IF NOT EXISTS `materias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(300) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.materias: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.menucontent
DROP TABLE IF EXISTS `menucontent`;
CREATE TABLE IF NOT EXISTS `menucontent` (
  `id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `icon` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `link` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '#',
  `target` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT 'content',
  `priority` int(11) NOT NULL DEFAULT '0',
  `active` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.menucontent: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `menucontent` DISABLE KEYS */;
INSERT INTO `menucontent` (`id`, `name`, `icon`, `link`, `target`, `priority`, `active`) VALUES
	(0, 'Inicio', 'home', 'cuenta/inicio.jsp', 'content', 5, 1),
	(1, 'Logout', 'exit_to_app', 'cuenta/logout.jsp', '_self', 0, 1),
	(2, 'Usuarios', 'person', 'admin/usuarios/', 'content', 3, 1),
	(3, 'Modificar Cuenta', 'settings', 'cuenta/cambios/', 'content', 1, 1),
	(4, 'Horarios', 'border_all', 'horarios/', 'content', 2, 1),
	(5, 'Grupos', 'group', 'admin/grupos/', 'content', 3, 1),
	(6, 'Chat', 'chat', 'chat/', 'content', 3, 1),
	(7, 'Materias', 'library_books', 'materias/', 'content', 2, 1),
	(8, 'Administrar Horarios', 'border_all', 'admin/horarios', 'content', 3, 1);
/*!40000 ALTER TABLE `menucontent` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.messages: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `message`, `fecha`) VALUES
	(58, '[29/05/18 07:36:41]Axel Treviño -> &lt;h2&gt;algo&lt;/h2&gt;', '2018-05-29 19:36:41'),
	(59, '[29/05/18 07:36:46]Axel Treviño -> ya funciono', '2018-05-29 19:36:46');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.salones
DROP TABLE IF EXISTS `salones`;
CREATE TABLE IF NOT EXISTS `salones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.salones: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `salones` DISABLE KEYS */;
INSERT INTO `salones` (`id`, `nombre`) VALUES
	(1, 'Salon 1');
/*!40000 ALTER TABLE `salones` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.tipousuario
DROP TABLE IF EXISTS `tipousuario`;
CREATE TABLE IF NOT EXISTS `tipousuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `icon` varchar(75) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.tipousuario: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` (`id`, `nombre`, `icon`) VALUES
	(0, 'Alumno', 'create'),
	(1, 'Profesor', 'book'),
	(2, 'Prefecto', 'assignment'),
	(3, 'Administrador', 'star_border');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;

-- Volcando estructura para tabla isalon.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(250) CHARACTER SET utf8 NOT NULL,
  `name` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT 'SIN NOMBRE',
  `pass` int(11) NOT NULL,
  `tipo` int(11) NOT NULL DEFAULT '0',
  `image` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla isalon.usuarios: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `username`, `name`, `pass`, `tipo`, `image`) VALUES
	(10, 'laxelott', 'Axel Treviño', 1510372, 3, NULL),
	(27, 'isaac', 'Isaac Cortes Rosales', 46792755, 0, NULL),
	(29, 'pantallazo', 'Jonathan Mugnoz', 48690, 1, NULL),
	(30, 'ana?', '----\'Ana', 173283454, 2, NULL),
	(31, 'diego', 'Diego de la Rocha', 48690, 2, NULL),
	(34, 'sergio', 'Sergio Moreno', 48690, 3, NULL),
	(35, 'rodrigo', 'Rodrigo', 48690, 0, NULL),
	(42, 'beriaru-chan', 'Emanuel Aaron', 48690, 3, NULL),
	(44, 'jimmy', 'Jaime Minor Gomez', 96354, 1, NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Volcando estructura para procedimiento isalon.validarUsuario
DROP PROCEDURE IF EXISTS `validarUsuario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `validarUsuario`(in u nvarchar(250), in p int)
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

end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
