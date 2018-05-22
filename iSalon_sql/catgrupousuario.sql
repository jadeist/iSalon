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

-- Dumping structure for table isalon.catgrupousuario
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
