-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.36-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for hotel
CREATE DATABASE IF NOT EXISTS `hotel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `hotel`;

-- Dumping structure for table hotel.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `customerIDCard` char(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customerGender` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customerName` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customerBirthday` date DEFAULT NULL,
  `customerVIPLevel` smallint(6) DEFAULT NULL,
  `customerPhoneNumber` char(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `totalAmount` int(10) unsigned DEFAULT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`customerIDCard`),
  KEY `indexCustomerName` (`customerName`),
  KEY `indexCustomerPhoneNumber` (`customerPhoneNumber`),
  KEY `indexCustomerVIPLevel` (`customerVIPLevel`),
  KEY `FK_customers_hotels` (`hotelID`),
  CONSTRAINT `FK_customers_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`customerVIPLevel`) REFERENCES `viplevel` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.customers: ~0 rows (approximately)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Dumping structure for table hotel.hotels
CREATE TABLE IF NOT EXISTS `hotels` (
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `tel` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.hotels: ~2 rows (approximately)
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` (`hotelID`, `name`, `address`, `tel`, `tax`) VALUES
	('HOT001', 'Khách sạn Victoria Cần Thơ', 'Cai Khe Ward, Ninh Kieu District Can Tho City', '0292 3810 111', '18011123456'),
	('HOT002', 'Khách sạn Vinperl Cần Thơ', 'Xuân Khánh, Cần Thơ', '02923 3777 7777', '180112345674');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;

-- Dumping structure for table hotel.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `orderNumber` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderStatus` char(18) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customerIDCard` char(18) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roomNumber` char(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkInTime` date NOT NULL,
  `checkOutTime` date NOT NULL,
  `totalMoney` int(10) unsigned NOT NULL,
  `waiterID` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orderTime` date NOT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`orderNumber`),
  KEY `customerIDCard` (`customerIDCard`),
  KEY `roomNumber` (`roomNumber`),
  KEY `waiterID` (`waiterID`),
  KEY `indexOrderStatusNumber` (`orderNumber`,`orderStatus`),
  KEY `FK_orders_hotels` (`hotelID`),
  CONSTRAINT `FK_orders_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerIDCard`) REFERENCES `customers` (`customerIDCard`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`roomNumber`) REFERENCES `room` (`roomNumber`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`waiterID`) REFERENCES `waiter` (`waiterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.orders: ~0 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table hotel.ordertracking
CREATE TABLE IF NOT EXISTS `ordertracking` (
  `orderNumber` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderTime` date NOT NULL,
  `checkInTime` date DEFAULT NULL,
  `checkOutTime` date DEFAULT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceID` int(11) DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `FK_ordertracking_services` (`serviceID`),
  CONSTRAINT `FK_ordertracking_services` FOREIGN KEY (`serviceID`) REFERENCES `services` (`serviceID`),
  CONSTRAINT `ordertracking_ibfk_1` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.ordertracking: ~0 rows (approximately)
/*!40000 ALTER TABLE `ordertracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordertracking` ENABLE KEYS */;

-- Dumping structure for table hotel.room
CREATE TABLE IF NOT EXISTS `room` (
  `roomNumber` char(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roomType` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roomStatus` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`roomNumber`),
  KEY `indexRoomTypeStatus` (`roomType`,`roomStatus`(191)),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`roomType`) REFERENCES `roomtypeandprice` (`roomType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.room: ~106 rows (approximately)
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` (`roomNumber`, `roomType`, `roomStatus`, `remarks`) VALUES
	('000001', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000002', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000003', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000004', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000005', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000006', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000007', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000008', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000009', 'Tiêu_chuẩn (Đơn)', 'đã_có_người_thuê', NULL),
	('000010', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000011', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000012', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000013', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000014', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000015', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000016', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000017', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000018', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000019', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000020', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000021', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000022', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000023', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000024', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000025', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000026', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000027', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000028', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000029', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000030', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000031', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000032', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000033', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000034', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000035', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000036', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000037', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000038', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000039', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000040', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000041', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000042', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000043', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000044', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000045', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000046', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000047', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000048', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000049', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000050', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000051', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000052', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000053', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000054', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000055', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000056', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000057', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000058', 'Doanh_nhân (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000059', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000060', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000061', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000062', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000063', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000064', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000065', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000066', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000067', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000068', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000069', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000070', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000071', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000072', 'Doanh_nhân (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000073', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000074', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000075', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000076', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000077', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000078', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000079', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000080', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000081', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000082', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000083', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000084', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000085', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000086', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('000087', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000088', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000089', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000090', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000091', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL),
	('000092', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000093', 'Doanh_nhân (Đơn / Đôi)', 'đã_có_người_thuê', NULL),
	('000094', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000095', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL),
	('000096', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000097', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('000098', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000099', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('000100', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000101', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL),
	('000102', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL),
	('001188', 'VIP (Đơn / Đôi)', 'còn_trống', NULL),
	('012341', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL),
	('100000', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', ''),
	('123422', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', '');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;

-- Dumping structure for table hotel.roomtypeandprice
CREATE TABLE IF NOT EXISTS `roomtypeandprice` (
  `roomType` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `desc` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`roomType`,`hotelID`),
  KEY `indexRoomTypePrice` (`roomType`,`price`),
  KEY `FK_roomtypeandprice_hotels` (`hotelID`),
  CONSTRAINT `FK_roomtypeandprice_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.roomtypeandprice: ~10 rows (approximately)
/*!40000 ALTER TABLE `roomtypeandprice` DISABLE KEYS */;
INSERT INTO `roomtypeandprice` (`roomType`, `price`, `desc`, `url`, `hotelID`) VALUES
	('Doanh_nhân (Đơn / Đôi)', 318, 'Rộng 18-20㎡ | giườn 1.8m | Lầu：2-4 | Có ban công', '/images/5.jpg', 'HOT001'),
	('Doanh_nhân (Đơn / Đôi)', 450, 'Rộng 18-20㎡ | giườn 1.8m | Lầu：2-4 | Có ban công', '/images/5.jpg', 'HOT002'),
	('Nữ hoàng (Đơn / Đôi)', 188, 'Rộng 12㎡ | Giường đôi 1.5m | Lầu：2-4 | Có ban công', '/images/4.jpg', 'HOT001'),
	('Nữ hoàng (Đơn / Đôi)', 600, 'Rộng 12㎡ | Giường đôi 1.5m | Lầu：2-4 | Có ban công', '/images/4.jpg', 'HOT002'),
	('Tiêu_chuẩn (Đôi)', 258, 'Phòng 20-25㎡ | 2 giường, mỗi giường 1.2m | Lầu：2-4 | Có ban công', '/images/1.jpg', 'HOT001'),
	('Tiêu_chuẩn (Đôi)', 300, 'Phòng 20-25㎡ | 2 giường, mỗi giường 1.2m | Lầu：2-4 | Có ban công', '/images/1.jpg', 'HOT002'),
	('Tiêu_chuẩn (Đơn)', 178, 'Phòng: 18m2 | Giường 1.2m | Lầu: 1 | Có ban công', '/images/2.jpg', 'HOT001'),
	('Tiêu_chuẩn (Đơn)', 150, 'Phòng: 18m2 | Giường 1.2m | Lầu: 1 | Có ban công', '/images/2.jpg', 'HOT002'),
	('VIP (Đơn / Đôi)', 450, 'Phòng: 16-20m2 | Giường 1.5m | Lầu: 2-5 | có ban công, tivi, tủ lạnh', '/images/3.jpg', 'HOT001'),
	('VIP (Đơn / Đôi)', 999, 'Phòng: 16-20m2 | Giường 1.5m | Lầu: 2-5 | có ban công, tivi, tủ lạnh', '/images/3.jpg', 'HOT002');
/*!40000 ALTER TABLE `roomtypeandprice` ENABLE KEYS */;

-- Dumping structure for table hotel.services
CREATE TABLE IF NOT EXISTS `services` (
  `serviceID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`serviceID`),
  KEY `FK_services_hotels` (`hotelID`),
  CONSTRAINT `FK_services_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.services: ~6 rows (approximately)
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` (`serviceID`, `name`, `price`, `hotelID`) VALUES
	(1, 'Giặt ủi', 5.0000, 'HOT001'),
	(2, 'Ăn trưa', 15.0000, 'HOT001'),
	(3, 'Ăn tối', 20.0000, 'HOT001'),
	(4, 'Giặt ủi', 15.0000, 'HOT002'),
	(5, 'Ăn trưa', 55.0000, 'HOT002'),
	(6, 'Ăn tối', 99.0000, 'HOT002');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;

-- Dumping structure for table hotel.systemadministrator
CREATE TABLE IF NOT EXISTS `systemadministrator` (
  `userID` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userName` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userPassword` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`userID`),
  KEY `indexSystemAdminIDPassword` (`userID`,`userPassword`),
  KEY `FK_systemadministrator_hotels` (`hotelID`),
  CONSTRAINT `FK_systemadministrator_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.systemadministrator: ~3 rows (approximately)
/*!40000 ALTER TABLE `systemadministrator` DISABLE KEYS */;
INSERT INTO `systemadministrator` (`userID`, `userName`, `userPassword`, `hotelID`) VALUES
	('admin', 'Quản trị Hệ thống', '1234', NULL),
	('adminVicto', 'Quản trị Hệ thống Victoria', '1234', 'HOT001'),
	('adminVinpe', 'Quản trị Hệ thống VinPerl', '1234', 'HOT002');
/*!40000 ALTER TABLE `systemadministrator` ENABLE KEYS */;

-- Dumping structure for table hotel.timeextension
CREATE TABLE IF NOT EXISTS `timeextension` (
  `operatingID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderNumber` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oldExpiryDate` date NOT NULL,
  `newExpiryDate` date NOT NULL,
  `addedMoney` int(10) unsigned NOT NULL,
  PRIMARY KEY (`operatingID`),
  KEY `orderNumber` (`orderNumber`),
  CONSTRAINT `timeextension_ibfk_1` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.timeextension: ~0 rows (approximately)
/*!40000 ALTER TABLE `timeextension` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeextension` ENABLE KEYS */;

-- Dumping structure for table hotel.viplevel
CREATE TABLE IF NOT EXISTS `viplevel` (
  `level` smallint(6) NOT NULL,
  `discount` decimal(10,2) unsigned NOT NULL,
  `totalAmount` bigint(20) DEFAULT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`level`,`hotelID`),
  KEY `FK_viplevel_hotels` (`hotelID`),
  CONSTRAINT `FK_viplevel_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.viplevel: ~6 rows (approximately)
/*!40000 ALTER TABLE `viplevel` DISABLE KEYS */;
INSERT INTO `viplevel` (`level`, `discount`, `totalAmount`, `remarks`, `hotelID`) VALUES
	(1, 0.99, 200, NULL, 'HOT001'),
	(2, 0.98, 500, NULL, 'HOT001'),
	(3, 0.97, 1000, NULL, 'HOT001'),
	(4, 0.96, 2000, NULL, 'HOT001'),
	(5, 0.95, 3000, NULL, 'HOT001'),
	(6, 0.94, 5000, NULL, 'HOT001');
/*!40000 ALTER TABLE `viplevel` ENABLE KEYS */;

-- Dumping structure for table hotel.waiter
CREATE TABLE IF NOT EXISTS `waiter` (
  `waiterID` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waiterName` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waiterBirthday` date NOT NULL,
  `waiterIDCard` char(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waiterPassword` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waiterJoinDate` date NOT NULL,
  `waiterPhoneNumber` char(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hotelID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`waiterID`),
  KEY `indexWaiterIDPassword` (`waiterID`,`waiterPassword`),
  KEY `FK_waiter_hotels` (`hotelID`),
  CONSTRAINT `FK_waiter_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.waiter: ~4 rows (approximately)
/*!40000 ALTER TABLE `waiter` DISABLE KEYS */;
INSERT INTO `waiter` (`waiterID`, `waiterName`, `waiterBirthday`, `waiterIDCard`, `waiterPassword`, `waiterJoinDate`, `waiterPhoneNumber`, `remarks`, `hotelID`) VALUES
	('dnpcuong', 'Dương Nguyễn Phú Cường', '1989-06-11', '362209685', '1234', '2018-01-01', '0915659223', '', 'HOT001'),
	('lhsang', 'Lưu Hoài Sang', '1998-10-22', '362209684', '1234', '2017-12-06', '0909123456', '', 'HOT001'),
	('mtcnhung', 'Mai Thị Cẩm Nhung', '2017-12-28', '362209475', '1234', '2018-01-04', '0914785231', NULL, 'HOT002'),
	('tkadung', 'Tống Kim Anh Dũng', '2017-12-21', '362207485', '1234', '2017-12-05', '0914256842', NULL, 'HOT002');
/*!40000 ALTER TABLE `waiter` ENABLE KEYS */;

-- Dumping structure for view hotel.customerviplevelinfo
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `customerviplevelinfo` (
	`customerIDCard` CHAR(18) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`customerGender` CHAR(4) NULL COLLATE 'utf8mb4_unicode_ci',
	`customerName` VARCHAR(16) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`customerBirthday` DATE NULL,
	`customerVIPLevel` SMALLINT(6) NULL,
	`customerPhoneNumber` CHAR(11) NULL COLLATE 'utf8mb4_unicode_ci',
	`totalAmount` INT(10) UNSIGNED NULL,
	`remarks` VARCHAR(32) NULL COLLATE 'utf8mb4_unicode_ci',
	`hotelID` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`discount` DECIMAL(10,2) UNSIGNED NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view hotel.incomeview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `incomeview` (
	`co` DATE NOT NULL,
	`tot` DECIMAL(32,0) NULL,
	`num` BIGINT(21) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view hotel.orderviews
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `orderviews` (
	`orderNumber` CHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`orderStatus` CHAR(18) NULL COLLATE 'utf8mb4_unicode_ci',
	`customerName` VARCHAR(16) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`roomNumber` CHAR(6) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`roomType` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`orderTime` DATE NOT NULL,
	`checkInTime` DATE NOT NULL,
	`checkOutTime` DATE NOT NULL,
	`customerPhoneNumber` CHAR(11) NULL COLLATE 'utf8mb4_unicode_ci',
	`totalMoney` INT(10) UNSIGNED NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view hotel.roominfo
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `roominfo` 
) ENGINE=MyISAM;

-- Dumping structure for view hotel.timeextensionordersview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `timeextensionordersview` (
	`orderNumber` CHAR(32) NULL COLLATE 'utf8mb4_unicode_ci',
	`customerName` VARCHAR(16) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`customerPhoneNumber` CHAR(11) NULL COLLATE 'utf8mb4_unicode_ci',
	`roomNumber` CHAR(6) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`checkInTime` DATE NOT NULL,
	`oldExpiryDate` DATE NOT NULL,
	`newExpiryDate` DATE NOT NULL,
	`addedMoney` INT(10) UNSIGNED NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for trigger hotel.insertAddMoneyToOrdersTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `insertAddMoneyToOrdersTrigger` BEFORE INSERT ON `orders` FOR EACH ROW begin 
				UPDATE customers set totalAmount=totalAmount+new.totalMoney where customerIDCard=new.customerIDCard ;
			end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger hotel.insertCustomerLevelTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `insertCustomerLevelTrigger` BEFORE INSERT ON `customers` FOR EACH ROW begin 
# 消费金额<200 VIP等级为1
				if new.totalAmount<200
					then 
					set new.customerVIPLevel =1 ;
# 200<消费金额<500 VIP等级为2					
				elseif  new.totalAmount<500
					then 
					set new.customerVIPLevel =2 ;
# 500<消费金额<1000 VIP等级为3					
				elseif new.totalAmount<1000
					then 
					set new.customerVIPLevel =3 ;
# 1000<消费金额<2000 VIP等级为4
				elseif new.totalAmount<2000
					then 
					set new.customerVIPLevel =4 ;
# 2000<消费金额<3000 VIP等级为5				
				elseif new.totalAmount<3000
					then 
					set new.customerVIPLevel =5 ;
# 3000<消费金额<5000 VIP等级为6					
				elseif new.totalAmount<5000
					then 
					set new.customerVIPLevel =6 ;
					end if;
			end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger hotel.insertMoneyToTimeExtensionTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `insertMoneyToTimeExtensionTrigger` BEFORE INSERT ON `timeextension` FOR EACH ROW begin 
				
				UPDATE orders set totalMoney=totalMoney+new.addedMoney where  orderNumber=new.orderNumber ;
				UPDATE customers set totalAmount=totalAmount+new.addedMoney  WHERE customerIDCard = (select customerIDCard from orders where new.orderNumber=orderNumber) ;
			end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger hotel.insertOrderStatusToTrackingTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `insertOrderStatusToTrackingTrigger` AFTER INSERT ON `orders` FOR EACH ROW begin 
				if new.orderStatus='Đặt phòng中'
					then
					INSERT INTO ordertracking VALUES ( new.orderNumber, new.orderTime , NULL, NULL, NULL);
				elseif new.orderStatus='Đã đăng ký'
					then
					INSERT INTO ordertracking VALUES ( new.orderNumber, new.orderTime , NULL, NULL, NULL);
					update orderTracking set checkInTime=new.checkInTime ,orderTime=new.checkInTime where orderNumber=new.orderNumber ;
				elseif new.orderStatus='Đã thanh toán' 
					then
					INSERT INTO ordertracking VALUES ( new.orderNumber, new.orderTime , NULL, NULL, NULL);
					update orderTracking set checkInTime=new.checkInTime ,orderTime=new.checkInTime,checkOutTime=new.checkOutTime where orderNumber=new.orderNumber ;
				end if ;
				
				if new.orderStatus='Đã đăng ký'
					then
					update room  set roomStatus='đã_có_người_thuê' where roomNumber=new.roomNumber ;
				elseif new.orderStatus='Đã thanh toán'
					then 
					update room  set roomStatus='còn_trống' where roomNumber=new.roomNumber ;
				end if ;
			end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger hotel.updateCustomerLevelTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `updateCustomerLevelTrigger` BEFORE UPDATE ON `customers` FOR EACH ROW begin 
				if new.totalAmount<200
					then 
					set new.customerVIPLevel =1 ;
					
				elseif  new.totalAmount<500
					then 
					set new.customerVIPLevel =2 ;
					
				elseif new.totalAmount<1000
					then 
					set new.customerVIPLevel =3 ;
				elseif new.totalAmount<2000
					then 
					set new.customerVIPLevel =4 ;
				elseif new.totalAmount<3000
					then 
					set new.customerVIPLevel =5 ;
				elseif new.totalAmount<5000
					then 
					set new.customerVIPLevel =6 ;
					end if;
			end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger hotel.updateOrderStatustoTrackingTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `updateOrderStatustoTrackingTrigger` BEFORE UPDATE ON `orders` FOR EACH ROW begin 
				
				if new.orderStatus='Đã đăng ký'
					then
					update orderTracking set checkInTime=new.checkInTime  where orderNumber=new.orderNumber ;
				elseif new.orderStatus='Đã thanh toán'
					then 
					update orderTracking set checkOutTime=new.checkOutTime where orderNumber=new.orderNumber ;
				end if ;
				
				if new.orderStatus='Đã đăng ký'
					then
					update room  set roomStatus='đã_có_người_thuê' where roomNumber=new.roomNumber ;
				elseif new.orderStatus='Đã thanh toán'
					then 
					update room  set roomStatus='còn_trống' where roomNumber=new.roomNumber ;
				end if ;
			end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for view hotel.customerviplevelinfo
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `customerviplevelinfo`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `customerviplevelinfo` AS # 选择客户以及对应的VIP等级
select 
    customers.*, viplevel.discount
from
    customers, viplevel
where
    customers.customerVIPLevel = viplevel.level ;

-- Dumping structure for view hotel.incomeview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `incomeview`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `incomeview` AS # 选择退房时间，总金额，订单数量
select checkOutTime co, sum(totalMoney) tot, count(*) num from orders 
where orders.orderNumber
in (
select ordertracking.orderNumber from ordertracking
    where ordertracking.checkOutTime is not null
)
group by co ;

-- Dumping structure for view hotel.orderviews
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `orderviews`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `orderviews` AS SELECT
    orders.orderNumber,
    orders.orderStatus,
    customers.customerName,
    room.roomNumber,
    room.roomType,
    orders.orderTime,
    orders.checkInTime,
    orders.checkOutTime,
    customers.customerPhoneNumber,
    orders.totalMoney FROM
    orders, room, customers, roomtypeandprice
WHERE
    orders.customerIDCard = customers.customerIDCard
AND
    room.roomType = roomtypeandprice.roomType
AND 
    orders.roomNumber = room.roomNumber
ORDER BY
    orders.orderNumber DESC ;

-- Dumping structure for view hotel.roominfo
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `roominfo`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `roominfo` AS select 
    room.*, rp.price, rp.`desc`,
    rp.url
FROM
    room, roomtypeandprice rp
WHERE
    room.roomType = rp.roomType ;

-- Dumping structure for view hotel.timeextensionordersview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `timeextensionordersview`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `timeextensionordersview` AS # 选择订单号，顾客名，Số điện thoại，房间号，入住时间，旧的到期时间，新的到期时间以及增加的金额
SELECT 
    tt.orderNumber,
    ct.customerName,
    ct.customerPhoneNumber,
    od.roomNumber,
    od.checkInTime,
    tt.oldExpiryDate,
    tt.newExpiryDate,
    tt.addedMoney
FROM
    timeextension tt, orders od, customers ct
WHERE
    tt.orderNumber = od.orderNumber
AND
    od.customerIDCard = ct.customerIDCard ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
