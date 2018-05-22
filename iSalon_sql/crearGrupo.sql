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

-- Dumping structure for procedure isalon.crearGrupo
DROP PROCEDURE IF EXISTS `crearGrupo`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearGrupo`(
	IN `n` nvarchar(250)

)
begin 

	declare isValid int;
	declare num int;
	declare message nvarchar(200);
	
	set num = (select count(*) from grupos where nombre = n);
	
	if num = 0 then
		insert into grupos(nombre)
			values (n);
	
		set message = "Grupo creado!";
		set num = (select id from grupos where nombre = n);
		set isValid = 1;
	else 
		set message = "Grupo ya existe!";
		set num = -1;
		set isValid = 0;
	end if;
	
	select message, num as id, isValid;

end//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
