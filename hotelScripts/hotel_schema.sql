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

-- Dumping data for table hotel.customers: ~99 rows (approximately)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`customerIDCard`, `customerGender`, `customerName`, `customerBirthday`, `customerVIPLevel`, `customerPhoneNumber`, `totalAmount`, `remarks`, `hotelID`) VALUES
	('10611671', 'Nữ', 'Dr. Javier Strom', '1978-07-21', 1, '881-770-273', 151493, 'Ut qui doloremque et ad.', 'HOT002'),
	('11355464', 'Nam', 'Mrs. Gisselle Hu', '2012-05-14', 3, '(538) 804-5', 1301621, 'Autem quod inventore et doloribu', 'HOT002'),
	('11474395', 'Nữ', 'Genesis Larson', '2018-06-10', 1, '598-667-374', 9, 'Et recusandae qui consequatur su', 'HOT002'),
	('12543355', 'Nam', 'Mr. Mateo Heller', '2007-10-07', 1, '+1-995-460-', 302014953, 'Impedit quidem est non modi nihi', 'HOT001'),
	('13517325', 'Nam', 'Mrs. Justine Mag', '1984-05-24', 4, '(432) 310-8', 1204664, 'Aut accusamus fugit accusantium ', 'HOT002'),
	('14266284', 'Nam', 'Savanah Cremin', '1982-11-13', 3, '1-517-641-8', 543, 'Tenetur qui repellendus quo illu', 'HOT001'),
	('14946417', 'Nam', 'Estell Stoltenbe', '2017-07-26', 4, '636-353-688', 39120820, 'Sit modi placeat qui sequi sint ', 'HOT001'),
	('1509436', 'Nữ', 'Maxie Luettgen', '2017-08-16', 6, '+1-926-781-', 691279, 'Dolor est architecto quam repreh', 'HOT002'),
	('16110811', 'Nữ', 'Prof. Emelie Tro', '1978-09-28', 1, '1-326-366-0', 1415955, 'Ea et nisi ea inventore nemo.', 'HOT001'),
	('18763615', 'Nam', 'Dr. Lucas Kshler', '2006-02-22', 3, '837.424.884', 6961, 'Harum perferendis blanditiis exc', 'HOT001'),
	('19003424', 'Nam', 'Dr. Edwardo Jenk', '2002-10-08', 5, '(548) 641-0', 811621, 'Sint fugit nemo et quidem.', 'HOT002'),
	('19056894', 'Nam', 'Jewell Batz', '2015-05-12', 5, '603.261.933', 58260252, 'Quia sit rerum rerum.', 'HOT002'),
	('20022953', 'Nam', 'Makenzie Bechtel', '1984-04-20', 2, '779-586-825', 192077, 'Iste autem saepe culpa impedit.', 'HOT001'),
	('20274088', 'Nam', 'Ricky Auer', '1992-12-23', 2, '1-260-451-0', 64397666, 'Magni optio et ut ipsum aut impe', 'HOT001'),
	('21819806', 'Nam', 'Brittany Kutch', '2003-09-21', 3, '(724) 385-6', 91387141, 'Temporibus ad sit facilis minima', 'HOT002'),
	('23798729', 'Nữ', 'Ms. Joy Ryan', '2012-06-24', 6, '1-381-750-7', 12852, 'Excepturi harum quaerat laborios', 'HOT001'),
	('24645317', 'Nam', 'Jackie Johns', '1979-03-11', 4, '1-781-918-6', 27518, 'Qui tempore vitae pariatur volup', 'HOT002'),
	('24909978', 'Nữ', 'Durward Ruecker', '1998-05-29', 1, '+1 (792) 60', 10168794, 'Nemo sunt odio quod id aut vitae', 'HOT002'),
	('2567558', 'Nam', 'Amiya Leffler Jr', '2003-07-22', 1, '(375) 354-8', 4706450, 'Est qui deleniti placeat eligend', 'HOT001'),
	('277633', 'Nữ', 'Deven Pacocha', '1993-05-25', 1, '+1.947.826.', 3, 'Minus eos sed aut nemo aut.', 'HOT002'),
	('27892323', 'Nữ', 'Mr. Rolando Quit', '1987-09-03', 4, '+1681305961', 81821, 'Quaerat at hic ea rerum itaque e', 'HOT002'),
	('28539459', 'Nam', 'Cecelia Boyer', '2007-07-31', 1, '619.675.033', 477057, 'Quam consequatur in ea eveniet n', 'HOT001'),
	('29147432', 'Nữ', 'Rahul Bernier', '1997-05-09', 3, '+1 (996) 26', 619, 'Ducimus quis ipsum officia et.', 'HOT002'),
	('30287404', 'Nữ', 'Dominique McCull', '1971-05-18', 3, '1-935-361-1', 4775312, 'Et ducimus expedita ut quisquam.', 'HOT001'),
	('30700923', 'Nam', 'Orpha Abbott', '2007-04-12', 1, '(256) 335-6', 6336300, 'Officiis voluptas sapiente quibu', 'HOT002'),
	('3100012', 'Nữ', 'Kamille Bashiria', '2015-03-20', 1, '437.606.965', 1, 'Quaerat at cupiditate sint exerc', 'HOT001'),
	('31607595', 'Nam', 'Dr. Donavon Bins', '1977-09-08', 3, '854.586.516', 828, 'Pariatur cumque optio quidem fac', 'HOT002'),
	('31868779', 'Nam', 'Nicolette Schnei', '1990-06-07', 1, '1-215-815-8', 82, 'Quidem soluta nisi quam perspici', 'HOT002'),
	('3306547', 'Nữ', 'Eli Luettgen', '2007-07-24', 1, '780-303-725', 16, 'Ut odit sed cumque accusamus.', 'HOT002'),
	('34788312', 'Nam', 'Everardo Ernser', '2008-08-14', 3, '(583) 832-3', 62587921, 'In molestiae tenetur autem.', 'HOT001'),
	('36172919', 'Nam', 'Mrs. Dejah DuBuq', '1992-05-04', 1, '841.319.520', 8, 'Odio et laborum sed voluptas mag', 'HOT001'),
	('37021866', 'Nam', 'Deron Hane', '2002-03-20', 1, '941.366.773', 8, 'Harum qui soluta eos suscipit qu', 'HOT001'),
	('3777761', 'Nữ', 'Prof. Deondre Fr', '1970-05-13', 1, '+1720488763', 3, 'Expedita alias a aut et esse qui', 'HOT002'),
	('39353269', 'Nữ', 'Dr. Leopoldo Fei', '2003-01-23', 3, '(327) 997-4', 948, 'Eaque non dolor aliquid repudian', 'HOT001'),
	('39432224', 'Nam', 'Kyla Wintheiser', '2012-12-15', 6, '949.843.248', 4702, 'Et repudiandae voluptatem qui ex', 'HOT002'),
	('40135243', 'Nữ', 'Dr. Humberto Loc', '1986-02-28', 1, '1-787-723-7', 55591, 'Exercitationem qui necessitatibu', 'HOT001'),
	('40538914', 'Nam', 'Laron Champlin', '1990-04-10', 5, '351.398.155', 54704739, 'Vel quo minus consequatur et quo', 'HOT001'),
	('40646606', 'Nam', 'Dan Botsford', '1997-05-31', 1, '+1-918-759-', 70, 'Deleniti rerum sit corporis aspe', 'HOT002'),
	('40761622', 'Nam', 'Arno Morissette', '2015-11-14', 4, '+1.794.266.', 54157, 'Voluptatem deserunt repellendus ', 'HOT001'),
	('41082635', 'Nữ', 'Jamil Towne V', '1997-03-10', 2, '+1-510-415-', 36454747, 'Sit maxime est beatae in natus a', 'HOT002'),
	('45792068', 'Nam', 'Wilhelmine Kassu', '2007-03-10', 1, '324-323-959', 232469372, 'Autem et est odit voluptatem sed', 'HOT001'),
	('46372287', 'Nữ', 'Bernardo Mayert', '1991-09-11', 2, '631-942-920', 471, 'Quam asperiores ex est neque vol', 'HOT002'),
	('46709503', 'Nữ', 'Javonte Davis', '2017-02-27', 6, '(896) 331-9', 3082, 'Soluta alias unde ex nesciunt.', 'HOT001'),
	('47036826', 'Nam', 'Davonte Marquard', '1995-08-11', 4, '1-329-443-1', 14470713, 'Velit sit delectus autem sed lab', 'HOT002'),
	('47528161', 'Nữ', 'Laurence Nitzsch', '1980-02-25', 2, '(736) 858-5', 231, 'Illum voluptatem voluptate minus', 'HOT002'),
	('4815046', 'Nam', 'Miss Janae Mosci', '2017-05-01', 1, '(829) 775-1', 88375671, 'Consequatur est repellat necessi', 'HOT002'),
	('48312842', 'Nam', 'Don Fahey IV', '1973-05-06', 5, '373.654.618', 2447, 'Voluptatibus consectetur iusto e', 'HOT001'),
	('49612745', 'Nữ', 'Mafalda Jacobs', '2019-11-26', 1, '754-506-298', 43, 'Et rerum consequatur vero eligen', 'HOT002'),
	('4986329', 'Nữ', 'Prof. Ethelyn Ba', '1992-04-07', 1, '325.406.284', 75, 'Voluptate minus est quas id eos ', 'HOT001'),
	('50065385', 'Nữ', 'Ezequiel Johnson', '1994-01-28', 4, '(879) 949-6', 656082500, 'Architecto ut autem eaque volupt', 'HOT002'),
	('50209284', 'Nữ', 'Dr. Andre Moriss', '2006-04-30', 5, '1-573-879-2', 8042, 'Fugit vel laborum sapiente exped', 'HOT001'),
	('51665487', 'Nữ', 'Grover Heathcote', '1981-08-15', 6, '909-566-860', 301418, 'Impedit ut necessitatibus et nis', 'HOT002'),
	('52532349', 'Nam', 'Roscoe Waters DV', '1991-07-01', 3, '1-840-620-6', 816, 'Voluptas ut repellendus eos omni', 'HOT002'),
	('52561915', 'Nam', 'Miss Ova Bernier', '1970-08-16', 1, '429-965-424', 95, 'Praesentium ut neque ex ex neces', 'HOT002'),
	('52868933', 'Nam', 'Matt Beatty', '1977-10-20', 2, '(539) 913-0', 720019, 'Voluptatem molestiae velit vitae', 'HOT001'),
	('53963209', 'Nam', 'Maegan Sanford S', '2002-08-04', 1, '632-888-903', 545604, 'Perspiciatis ut id alias quae ma', 'HOT002'),
	('56062947', 'Nam', 'Prof. Bill Armst', '2009-04-21', 1, '673-547-084', 150, 'Dolorum cumque itaque et sequi e', 'HOT001'),
	('5619355', 'Nam', 'Dagmar Weber', '1970-05-02', 6, '1-779-488-2', 9620, 'Quas dicta officia quis.', 'HOT002'),
	('57672859', 'Nữ', 'Hattie Mann', '1993-04-03', 1, '942-550-023', 49, 'Aut magnam eum totam odit.', 'HOT001'),
	('60127199', 'Nữ', 'Arvel Harber', '1999-09-12', 4, '950.548.110', 32451, 'Fugiat nam id ipsum quasi.', 'HOT002'),
	('64043679', 'Nữ', 'Joana Prosacco', '1995-02-08', 4, '742.919.400', 61719069, 'Debitis eum tempore voluptatibus', 'HOT001'),
	('64373295', 'Nam', 'Maudie Kunze', '2008-05-30', 3, '1-517-930-5', 764, 'Eos veritatis excepturi harum te', 'HOT002'),
	('64601389', 'Nữ', 'Saul Volkman', '1995-05-08', 5, '+1-215-323-', 344053, 'Fuga rerum sapiente iure veritat', 'HOT002'),
	('65187687', 'Nữ', 'Sidney Towne', '1985-12-28', 3, '261-228-065', 692263772, 'Praesentium odio nesciunt evenie', 'HOT002'),
	('66304367', 'Nữ', 'Pink Pfeffer MD', '2005-10-23', 1, '384.456.853', 4, 'Minus autem laboriosam rerum fug', 'HOT002'),
	('66477973', 'Nữ', 'Prof. Brian Pros', '1986-02-24', 3, '+1-396-285-', 364858752, 'Quis voluptatem ut illo dolores ', 'HOT001'),
	('67186035', 'Nữ', 'Prof. Guillermo ', '2000-03-31', 1, '292-767-084', 9, 'Culpa aliquid esse accusantium e', 'HOT002'),
	('67794111', 'Nam', 'Kamren Ratke', '2019-07-29', 3, '834.750.892', 828, 'Adipisci sapiente aut blanditiis', 'HOT002'),
	('7123094', 'Nam', 'Ayden Stoltenber', '1991-02-22', 5, '591-254-927', 49747, 'Ipsa et in molestiae veniam arch', 'HOT002'),
	('71468389', 'Nữ', 'Dr. Joseph Schme', '1970-04-26', 6, '(878) 207-6', 542458598, 'Sed non nemo voluptas perspiciat', 'HOT002'),
	('78760830', 'Nam', 'Prof. Kris Crona', '1970-11-07', 5, '1-917-598-7', 81396495, 'Saepe porro et doloremque molest', 'HOT002'),
	('79638916', 'Nữ', 'Mr. Monte Blick ', '1999-05-05', 4, '(773) 309-4', 212471, 'Dignissimos atque rerum tenetur ', 'HOT001'),
	('79843175', 'Nữ', 'Mr. Kolby Lang', '1999-08-31', 4, '389.464.434', 816967, 'Adipisci aperiam voluptas et dol', 'HOT002'),
	('81455880', 'Nữ', 'Winfield Littel', '1987-08-04', 3, '+1552602213', 9605, 'Fugiat sint voluptate veniam pro', 'HOT002'),
	('81906630', 'Nữ', 'Glennie Collins', '2007-02-23', 6, '248.360.360', 77917341, 'Harum accusantium ut delectus co', 'HOT001'),
	('82137940', 'Nữ', 'River Morissette', '1991-04-10', 4, '+1515329810', 80356834, 'Sint culpa animi dolor quo.', 'HOT002'),
	('84256321', 'Nữ', 'Vincenza Kuphal ', '1994-08-11', 1, '1-675-587-7', 7, 'Ut earum et vitae tenetur aliqua', 'HOT001'),
	('85245413', 'Nam', 'Erick Mayer', '2001-05-21', 2, '1-808-509-2', 14131433, 'Quo autem magni dolorem aut ad s', 'HOT002'),
	('86205826', 'Nữ', 'Fleta Rodriguez', '1991-10-16', 4, '318.472.272', 6859579, 'Quasi aut magni omnis est molest', 'HOT002'),
	('86872334', 'Nam', 'Conrad Bayer', '1991-08-24', 3, '(367) 378-2', 640, 'Adipisci voluptas natus doloribu', 'HOT001'),
	('871054', 'Nam', 'Ludie Monahan I', '1974-08-18', 4, '392.342.244', 5131, 'Qui inventore dolor debitis numq', 'HOT001'),
	('87682679', 'Nam', 'Dr. Myles Durgan', '2010-01-22', 1, '373-412-818', 8, 'Numquam veniam cum ab enim.', 'HOT002'),
	('88296345', 'Nam', 'Maeve Kuhic', '1975-04-16', 2, '735-213-500', 23050655, 'Aut sit et officiis quo id delec', 'HOT001'),
	('88554074', 'Nữ', 'Leatha Goodwin', '1999-12-10', 5, '(871) 940-6', 55774488, 'Enim et nemo quaerat atque praes', 'HOT002'),
	('88611213', 'Nữ', 'Dr. Syble Osinsk', '1971-09-02', 1, '280-292-759', 8, 'Consequatur et deleniti possimus', 'HOT001'),
	('88620785', 'Nam', 'Earnestine Gulgo', '1978-07-27', 2, '1-290-754-7', 22538, 'Est aut itaque ut et.', 'HOT001'),
	('89137368', 'Nữ', 'Felipe Murray', '1972-01-18', 1, '201-741-752', 5, 'Blanditiis veritatis et dolorem ', 'HOT002'),
	('89708956', 'Nữ', 'Dejah Hartmann P', '2009-03-27', 5, '(613) 671-6', 45316612, 'Et nostrum nihil magni sed volup', 'HOT001'),
	('89790009', 'Nữ', 'Green Greenfelde', '1973-04-22', 4, '326-722-148', 316621, 'Commodi quis cumque eveniet aut.', 'HOT001'),
	('90178641', 'Nam', 'Niko Bogisich Jr', '2000-12-09', 2, '+1-945-814-', 73654586, 'Ut quia est voluptatem nihil.', 'HOT001'),
	('9117576', 'Nữ', 'Ariel Rau DDS', '1988-05-25', 3, '+1217969999', 1884535, 'Dignissimos odit quia omnis iust', 'HOT001'),
	('92130004', 'Nam', 'Keven Cruickshan', '1983-10-10', 4, '(403) 984-4', 25862332, 'Veritatis omnis consequuntur opt', 'HOT002'),
	('93608053', 'Nữ', 'Prof. Trinity Ku', '1977-10-02', 1, '+1.921.285.', 499795181, 'Omnis omnis maiores illo blandit', 'HOT001'),
	('93840775', 'Nam', 'Jaime Ryan', '2015-01-14', 6, '519-781-282', 77616139, 'Magnam repudiandae odit possimus', 'HOT002'),
	('96235020', 'Nam', 'Heber Breitenber', '1976-08-11', 2, '(743) 290-8', 342, 'Rerum eveniet voluptas rerum qui', 'HOT002'),
	('97291505', 'Nữ', 'Brandt Rosenbaum', '1992-08-22', 2, '209.571.592', 899313186, 'Nihil corporis ratione minima ad', 'HOT001'),
	('97495661', 'Nam', 'Mr. Cole Huels P', '2019-10-20', 2, '(658) 433-2', 5614, 'Totam modi saepe mollitia quia.', 'HOT001'),
	('98535545', 'Nữ', 'Amira Luettgen', '2019-03-31', 1, '912-867-314', 26784, 'Rerum accusamus aut nihil.', 'HOT001'),
	('98813307', 'Nam', 'Dayna Oberbrunne', '2000-08-25', 1, '(741) 981-4', 34542251, 'Vitae non omnis aut sit ipsam qu', 'HOT002'),
	('99644700', 'Nam', 'Prof. Jeffery Fr', '1986-06-27', 5, '345-573-228', 9919254, 'Et et deserunt nobis deserunt ex', 'HOT001');
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
  `serviceID_1` int(11) DEFAULT NULL,
  `price_1` decimal(10,4) DEFAULT NULL,
  `serviceID_2` int(11) DEFAULT NULL,
  `price_2` decimal(10,4) DEFAULT NULL,
  `serviceID_3` int(11) DEFAULT NULL,
  `price_3` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `customerIDCard` (`customerIDCard`),
  KEY `roomNumber` (`roomNumber`),
  KEY `waiterID` (`waiterID`),
  KEY `indexOrderStatusNumber` (`orderNumber`,`orderStatus`),
  KEY `FK_orders_hotels` (`hotelID`),
  KEY `FK_orders_services` (`serviceID_1`),
  KEY `FK_orders_services_2` (`serviceID_2`),
  KEY `FK_orders_services_3` (`serviceID_3`),
  CONSTRAINT `FK_orders_hotels` FOREIGN KEY (`hotelID`) REFERENCES `hotels` (`hotelID`),
  CONSTRAINT `FK_orders_services` FOREIGN KEY (`serviceID_1`) REFERENCES `services` (`serviceID`),
  CONSTRAINT `FK_orders_services_2` FOREIGN KEY (`serviceID_2`) REFERENCES `services` (`serviceID`),
  CONSTRAINT `FK_orders_services_3` FOREIGN KEY (`serviceID_3`) REFERENCES `services` (`serviceID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerIDCard`) REFERENCES `customers` (`customerIDCard`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`roomNumber`) REFERENCES `room` (`roomNumber`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`waiterID`) REFERENCES `waiter` (`waiterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table hotel.orders: ~4 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`orderNumber`, `orderStatus`, `customerIDCard`, `roomNumber`, `checkInTime`, `checkOutTime`, `totalMoney`, `waiterID`, `remarks`, `orderTime`, `hotelID`, `serviceID_1`, `price_1`, `serviceID_2`, `price_2`, `serviceID_3`, `price_3`) VALUES
	('14755271', 'Đã_đăng_ký', '4815046', '000038', '2019-12-12', '2020-01-11', 88375523, 'tkadung', 'Suscipit molestiae delectus duci', '2019-12-12', 'HOT002', 5, 55.0000, 2, 15.0000, 5, 55.0000),
	('17922951', 'Đã_thanh_toán', '47036826', '000056', '2019-10-30', '2019-11-23', 5397976, 'mtcnhung', 'Et blanditiis quia in enim.', '2019-10-30', 'HOT002', 1, 5.0000, 4, 15.0000, 3, 20.0000),
	('18972179', 'Đã_thanh_toán', '57672859', '000022', '2019-12-07', '2020-01-28', 40, 'tkadung', 'Et in exercitationem quo et.', '2019-12-07', 'HOT001', 5, 55.0000, 4, 15.0000, 3, 20.0000),
	('2745121', 'Đã_đăng_ký', '10611671', '000070', '2019-12-14', '2020-02-05', 151493, 'tkadung', 'Est perferendis cupiditate sit a', '2019-12-14', 'HOT002', 2, 15.0000, 2, 15.0000, 1, 5.0000),
	('32680230', 'Đã_thanh_toán', '31868779', '000086', '2019-12-03', '2019-12-15', 78, 'lhsang', 'Fugiat corporis deserunt cumque ', '2019-12-03', 'HOT002', 2, 15.0000, 6, 99.0000, 4, 15.0000),
	('36110712', 'Đã_thanh_toán', '39432224', '000002', '2019-10-30', '2020-01-21', 9, 'tkadung', 'Est necessitatibus nisi alias.', '2019-10-30', 'HOT002', 2, 15.0000, 5, 55.0000, 3, 20.0000),
	('39421557', 'Đã_thanh_toán', '78760830', '000021', '2019-10-29', '2020-02-12', 4, 'dnpcuong', 'Incidunt et maxime id non incidu', '2019-10-29', 'HOT002', 5, 55.0000, 3, 20.0000, 5, 55.0000),
	('4193633', 'Đã_thanh_toán', '88554074', '000025', '2019-10-06', '2019-12-12', 49869808, 'mtcnhung', 'Incidunt qui quibusdam nam dolor', '2019-10-06', 'HOT002', 5, 55.0000, 1, 5.0000, 5, 55.0000),
	('44766236', 'Đã_đăng_ký', '50065385', '000028', '2019-11-19', '2019-12-04', 8317944, 'mtcnhung', 'Eos officiis rerum tenetur et eo', '2019-11-19', 'HOT002', 2, 15.0000, 2, 15.0000, 1, 5.0000),
	('51087738', 'Đã_thanh_toán', '40761622', '000059', '2019-11-18', '2019-12-19', 24, 'dnpcuong', 'Voluptatem quos maxime necessita', '2019-11-18', 'HOT001', 2, 15.0000, 4, 15.0000, 6, 99.0000),
	('51730156', 'Đã_thanh_toán', '52868933', '000066', '2019-12-06', '2020-01-28', 842, 'lhsang', 'Et et quia beatae voluptatibus.', '2019-12-06', 'HOT001', 3, 20.0000, 3, 20.0000, 5, 55.0000),
	('52839588', 'Đã_đăng_ký', '71468389', '000070', '2019-10-05', '2019-12-10', 4, 'lhsang', 'Voluptatem iste itaque suscipit ', '2019-10-05', 'HOT002', 3, 20.0000, 3, 20.0000, 5, 55.0000),
	('55173543', 'Đã_đăng_ký', '11474395', '000078', '2019-12-18', '2020-01-09', 0, 'dnpcuong', 'Deleniti sint soluta quia.', '2019-12-18', 'HOT002', 4, 15.0000, 5, 55.0000, 6, 99.0000),
	('55716730', 'Đã_thanh_toán', '90178641', '000053', '2019-12-01', '2019-12-18', 73545991, 'dnpcuong', 'Sed officia quaerat et molestiae', '2019-12-01', 'HOT001', 3, 20.0000, 3, 20.0000, 3, 20.0000),
	('59074599', 'Đã_thanh_toán', '871054', '000102', '2019-11-09', '2020-02-10', 10, 'lhsang', 'Sint impedit soluta inventore.', '2019-11-09', 'HOT001', 1, 5.0000, 4, 15.0000, 4, 15.0000),
	('63749951', 'Đã_thanh_toán', '82137940', '000023', '2019-11-05', '2020-03-22', 2, 'lhsang', 'Dolore totam numquam recusandae ', '2019-11-05', 'HOT002', 2, 15.0000, 3, 20.0000, 5, 55.0000),
	('6885640', 'Đã_thanh_toán', '9117576', '000025', '2019-11-10', '2020-02-20', 1883819, 'tkadung', 'Sapiente id adipisci quia fuga.', '2019-11-10', 'HOT001', 6, 99.0000, 1, 5.0000, 1, 5.0000),
	('72481059', 'Đã_đăng_ký', '18763615', '000019', '2019-11-07', '2020-02-01', 1, 'mtcnhung', 'Iste sed itaque reiciendis reici', '2019-11-07', 'HOT001', 4, 15.0000, 4, 15.0000, 1, 5.0000),
	('76349293', 'Đã_thanh_toán', '81906630', '000044', '2019-11-07', '2019-12-21', 7, 'dnpcuong', 'Nulla occaecati doloremque ad vo', '2019-11-07', 'HOT001', 4, 15.0000, 3, 20.0000, 6, 99.0000),
	('77357287', 'Đã_thanh_toán', '97291505', '000027', '2019-10-18', '2019-12-05', 5159, 'tkadung', 'Natus est veritatis vero fuga se', '2019-10-18', 'HOT001', 6, 99.0000, 2, 15.0000, 3, 20.0000),
	('79120855', 'Đã_đăng_ký', '45792068', '000070', '2019-10-24', '2020-03-04', 232469335, 'tkadung', 'Perspiciatis earum asperiores ex', '2019-10-24', 'HOT001', 5, 55.0000, 1, 5.0000, 3, 20.0000),
	('80992644', 'Đã_đăng_ký', '89790009', '000071', '2019-11-27', '2020-01-31', 219548, 'tkadung', 'Iusto eveniet ea ipsa dicta quas', '2019-11-27', 'HOT001', 3, 20.0000, 1, 5.0000, 3, 20.0000),
	('83445318', 'Đã_đăng_ký', '98535545', '000054', '2019-10-15', '2019-11-29', 26729, 'dnpcuong', 'Facilis ut tempore dolorem et te', '2019-10-15', 'HOT001', 3, 20.0000, 5, 55.0000, 6, 99.0000),
	('84309537', 'Đã_đăng_ký', '18763615', '000021', '2019-12-09', '2020-02-18', 778, 'mtcnhung', 'Est praesentium voluptatem tempo', '2019-12-09', 'HOT001', 2, 15.0000, 3, 20.0000, 2, 15.0000),
	('90224612', 'Đã_thanh_toán', '88620785', '000080', '2019-10-10', '2020-01-17', 4410, 'lhsang', 'Repellat nihil ea id laudantium ', '2019-10-10', 'HOT001', 3, 20.0000, 4, 15.0000, 6, 99.0000),
	('98808451', 'Đã_đăng_ký', '34788312', '000048', '2019-12-19', '2020-01-25', 62066282, 'tkadung', 'Atque et ut molestias qui.', '2019-12-19', 'HOT001', 6, 99.0000, 1, 5.0000, 1, 5.0000);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table hotel.ordertracking
CREATE TABLE IF NOT EXISTS `ordertracking` (
  `orderNumber` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderTime` date NOT NULL,
  `checkInTime` date DEFAULT NULL,
  `checkOutTime` date DEFAULT NULL,
  `remarks` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
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
  `userName` VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL,
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




###### 视图 

# 创建收入视图
create view incomeView
as
# 选择Trả phòng时间，总金额，订单数量
select checkOutTime co, sum(totalMoney) tot, count(*) num from orders 
where orders.orderNumber
in (
select ordertracking.orderNumber from ordertracking
    where ordertracking.checkOutTime is not null
)
group by co ;


# 创建客户折扣视图
create view customerVipLevelInfo
as
# 选择客户以及对应的VIP等级
select 
    customers.*, viplevel.discount
from
    customers, viplevel
where
    customers.customerVIPLevel = viplevel.level ;

 
# 创建房间信息视图
CREATE VIEW roomInfo
AS
select 
    room.*, rp.price, rp.`desc`,
    rp.url
FROM
    room, roomtypeandprice rp
WHERE
    room.roomType = rp.roomType ;


# 创建Tình hình Renew视图
CREATE VIEW timeExtensionOrdersView
AS
# 选择Mã đơn hàng，顾客名，Số điện thoại，Số phòng，Ngày vào，旧的Ngày hết hạn，新的Ngày hết hạn以及增加的金额
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


# 创建订单视图
CREATE VIEW orderviews as
SELECT
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
    orders.orderNumber DESC;

-- ----------------------------
-- Triggers structure for table customers
-- ----------------------------
DROP TRIGGER IF EXISTS `insertCustomerLevelTrigger`;
delimiter ;;
# 创建客户折扣触发器
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
			end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table customers
-- ----------------------------
DROP TRIGGER IF EXISTS `updateCustomerLevelTrigger`;
delimiter ;;
# 创建客户消费金额更新后的触发器
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
			end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `insertAddMoneyToOrdersTrigger`;
delimiter ;;
# 创建更新的顾客消费总金额的触发器
CREATE TRIGGER `insertAddMoneyToOrdersTrigger` BEFORE INSERT ON `orders` FOR EACH ROW begin 
				UPDATE customers set totalAmount=totalAmount+new.totalMoney where customerIDCard=new.customerIDCard ;
			end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
# 创建插入订单后对Thông tin xác nhận进行更新的触发器
DROP TRIGGER IF EXISTS `insertOrderStatusToTrackingTrigger`;
delimiter ;;
CREATE TRIGGER `insertOrderStatusToTrackingTrigger` AFTER INSERT ON `orders` FOR EACH ROW begin 
				if new.orderStatus='Đặt phòng中'
					then
					INSERT INTO ordertracking VALUES ( new.orderNumber, new.orderTime , NULL, NULL, NULL);
				elseif new.orderStatus='Đã_đăng_ký'
					then
					INSERT INTO ordertracking VALUES ( new.orderNumber, new.orderTime , NULL, NULL, NULL);
					update orderTracking set checkInTime=new.checkInTime ,orderTime=new.checkInTime where orderNumber=new.orderNumber ;
				elseif new.orderStatus='Đã thanh toán' 
					then
					INSERT INTO ordertracking VALUES ( new.orderNumber, new.orderTime , NULL, NULL, NULL);
					update orderTracking set checkInTime=new.checkInTime ,orderTime=new.checkInTime,checkOutTime=new.checkOutTime where orderNumber=new.orderNumber ;
				end if ;
				
				if new.orderStatus='Đã_đăng_ký'
					then
					update room  set roomStatus='đã_có_người_thuê' where roomNumber=new.roomNumber ;
				elseif new.orderStatus='Đã thanh toán'
					then 
					update room  set roomStatus='còn_trống' where roomNumber=new.roomNumber ;
				end if ;
			end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `updateOrderStatustoTrackingTrigger`;
delimiter ;;
# 创建对订单完整性进行控制的触发器
CREATE TRIGGER `updateOrderStatustoTrackingTrigger` BEFORE UPDATE ON `orders` FOR EACH ROW begin 
				
				if new.orderStatus='Đã_đăng_ký'
					then
					update orderTracking set checkInTime=new.checkInTime  where orderNumber=new.orderNumber ;
				elseif new.orderStatus='Đã thanh toán'
					then 
					update orderTracking set checkOutTime=new.checkOutTime where orderNumber=new.orderNumber ;
				end if ;
				
				if new.orderStatus='Đã_đăng_ký'
					then
					update room  set roomStatus='đã_có_người_thuê' where roomNumber=new.roomNumber ;
				elseif new.orderStatus='Đã thanh toán'
					then 
					update room  set roomStatus='còn_trống' where roomNumber=new.roomNumber ;
				end if ;
			end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table timeextension
-- ----------------------------
# 创建对Tình hình Renew总金额进行更新的触发器
DROP TRIGGER IF EXISTS `insertMoneyToTimeExtensionTrigger`;
delimiter ;;
CREATE TRIGGER `insertMoneyToTimeExtensionTrigger` BEFORE INSERT ON `timeextension` FOR EACH ROW begin 
				
				UPDATE orders set totalMoney=totalMoney+new.addedMoney where  orderNumber=new.orderNumber ;
				UPDATE customers set totalAmount=totalAmount+new.addedMoney  WHERE customerIDCard = (select customerIDCard from orders where new.orderNumber=orderNumber) ;
			end
;;
delimiter ;


# 建立的索引 







/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;



UPDATE room SET room.roomStatus = 'còn_trống';

CREATE TEMPORARY TABLE IF NOT EXISTS tmpRoom AS (
	SELECT r.roomNumber
	FROM orders o
	JOIN room r ON o.roomNumber = r.roomNumber
	WHERE o.orderStatus = 'Đã_đăng_ký'
);

UPDATE room r1
SET r1.roomStatus = 'đã_có_người_thuê'
WHERE r1.roomNumber IN (
	SELECT roomNumber
	FROM tmpRoom
);
