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

-- Dumping structure for procedure isalon.validarUsuario
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
