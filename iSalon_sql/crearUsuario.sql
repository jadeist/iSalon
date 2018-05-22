-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.30-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for procedure isalon.crearUsuario
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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
