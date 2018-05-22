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

-- Dumping structure for procedure isalon.eliminarUsuario
DROP PROCEDURE IF EXISTS `eliminarUsuario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario`(in i int)
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

end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
