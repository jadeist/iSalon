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

-- Dumping structure for procedure isalon.editarUsuario
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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
