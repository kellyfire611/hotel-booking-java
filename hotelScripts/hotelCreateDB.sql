########################
# 1. Create Quản trị Hệ thống table
########################

CREATE TABLE systemAdministrator
(
	# 用户ID
	userID varchar(10), # varchar 
	# Tên tài khoản
	userName VARCHAR(32) NOT NULL,
	# Đăng nhậpMật khẩu
	userPassword VARCHAR(32) NOT NULL,
	# 主键
	PRIMARY KEY (userID)
) ENGINE=InnoDB;

########################
# 2. Create 服务员信息 table
########################

CREATE TABLE waiter
(
	# Mã Nhân viên
	waiterID varchar(10), #varchar
	# Tên
	waiterName VARCHAR(32) NOT NULL,
	# Ngày tháng năm sinh
	waiterBirthday DATE NOT NULL,
	# Card ID
	waiterIDCard CHAR(18) NOT NULL,
	# 系统Đăng nhậpMật khẩu
	waiterPassword VARCHAR(32) NOT NULL,
	# 入职ngày期
	waiterJoinDate DATE NOT NULL,
	# 手机
	waiterPhoneNumber CHAR(11),
	# Ghi chú
	remarks VARCHAR(32),
	# 主键
	PRIMARY KEY (waiterID)
) ENGINE=InnoDB;

########################
# 3. Create 会员信息 table
########################
CREATE TABLE VIPLevel
(
	# 会员等级（主码）
	level smallint,  # smallint  LV 1-10
	# 享受折扣
	discount decimal(10,2) unsigned,
	# 等级对应消费金额
	totalAmount bigint, # bigint
	# Ghi chú
	remarks VARCHAR(32),
	# 主键
	PRIMARY KEY (level)
) ENGINE=InnoDB;

########################
# 4. Create Loại phòng与价格 table
########################
CREATE TABLE roomTypeAndPrice
(
	# Loại phòng（主码）
	roomType VARCHAR(32),
	# Giá
	price INT UNSIGNED NOT NULL,
	
	`desc` VARCHAR(100),
	url varchar(40),
	# 主键
	PRIMARY KEY (roomType)

) ENGINE=InnoDB;

########################
# 5. Create 顾客信息 table
########################

CREATE TABLE customers
(
	# 顾客Card ID
	customerIDCard CHAR(18),
	# Giới tính
	customerGender CHAR(4) check (customerGender ='Nam' or customerGender='Nữ'),  # 限制 Nam或Nữ  
	# Tên
	customerName VARCHAR(16) NOT NULL,  
	# Ngày tháng năm sinh
	customerBirthday DATE, 
	# 会员等级
	customerVIPLevel smallint, # 改成 smallint 
	# Số điện thoại
	customerPhoneNumber CHAR(11) , 
	# 消费金额
	totalAmount INT UNSIGNED,  
	# Ghi chú
	remarks VARCHAR(32),  
	# 主键
	PRIMARY KEY (customerIDCard),
	# 外键
	FOREIGN KEY (customerVIPLevel) REFERENCES VIPLevel(level)

) ENGINE=InnoDB;

	
########################
# 6. Create 房间信息 table
########################
CREATE TABLE room
(
	# Số phòng（主码）
	roomNumber CHAR(6),
	# Loại phòng
	roomType VARCHAR(32) NOT NULL,
	# Tình trạng
	roomStatus CHAR(255) check (roomStatus='còn_trống' or roomStatus='đã_có_người_thuê'), # còn_trống/đã_có_người_thuê 
	# Ghi chú
	remarks VARCHAR(32),
	# 主键
	PRIMARY KEY (roomNumber),
	# 外键
	FOREIGN KEY (roomType) REFERENCES roomTypeAndPrice(roomType)
	
) ENGINE=InnoDB;


########################
# 7. Create Thông tin xác nhận table
# 已预订，Đã_đăng_ký，Đã thanh toán/已完成
# 三种订单都在里面
########################

CREATE TABLE orders
(
	# Mã đơn hàng
	orderNumber CHAR(32) NOT NULL  , 
	# Tình trạng Đơn hàng
	orderStatus CHAR(18) check (value in ('预订中','Đã_đăng_ký','Đã thanh toán')) ,
	# 客户Card ID
	customerIDCard CHAR(18),
	# 入住Số phòng
	roomNumber CHAR(6) NOT NULL,
	# Ngày vào
	checkInTime DATE NOT NULL,
	# Ngày ra
	checkOutTime DATE NOT NULL,
	# 需付金额(由于可能Gia hạn，不能作为外键)
	totalMoney INT UNSIGNED NOT NULL,
	# 服务员Mã Nhân viên
	waiterID VARCHAR(10) NOT NULL,
	# Ghi chú
	remarks VARCHAR(32),
	orderTime DATE NOT NULL,
	# 主键
	PRIMARY KEY (orderNumber),
	# 外键
	FOREIGN KEY (customerIDCard) REFERENCES customers(customerIDCard),

	FOREIGN KEY (roomNumber) REFERENCES room(roomNumber),

	FOREIGN KEY (waiterID) REFERENCES waiter(waiterID)

) ENGINE=InnoDB;

########################
# 8. Create 订单跟踪信息 table
# 时间为NULL表示订单没到当前Tình trạng
########################

CREATE TABLE orderTracking
(
	# Mã đơn hàng
	orderNumber CHAR(32),
	# Đặt phòng时间（订单表中一旦有Tình hình Đặt phòng加入，那么本表新增一条记录，本字段不可能为còn_trống）
	orderTime DATE NOT NULL,
	# 实际Ngày vào
	checkInTime DATE,
	# 实际Trả phòng时间
	checkOutTime DATE,
	# Ghi chú
	remarks VARCHAR(32),
	# 主键
	PRIMARY KEY (orderNumber),
	# 同时作为外键
	FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber)

) ENGINE=InnoDB;

########################
# 9. Create Gia hạn延长 table
# 客户需要Gia hạn延长时，直接更新订单表中的ngày期以及金额
# 由于Tình trạng Đơn hàng未变，跟踪表中无法体现该订单Gia hạn了，所以增加此Gia hạn表
########################
	
CREATE TABLE timeExtension    
(
	# 操作记录号
	operatingID INT UNSIGNED AUTO_INCREMENT,
	# 操作的Mã đơn hàng(是记录中的Mã đơn hàng，外码，参照订单表)
	orderNumber CHAR(32),
	# 住房原到期ngày期
	oldExpiryDate DATE NOT NULL,
	# 住房新到期ngày期
	newExpiryDate DATE NOT NULL,
	# 需要添加的金额
	addedMoney INT UNSIGNED NOT NULL,
	# 主键
	PRIMARY KEY (operatingID),
	# 外键
	FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber)

) ENGINE=InnoDB;



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

# 创建room 中roomtype和roomstatus 的混合索引
create index indexRoomTypeStatus on room (roomType, roomStatus);
# 创建Quản trị Hệ thốngid和password的混合索引
create index indexSystemAdminIDPassword on systemadministrator (userID, userPassword);
# 创建Quản trị Khách sạnid和password的混合索引
create index indexWaiterIDPassword on waiter (waiterID, waiterPassword);
# 创建customers中Tên的索引
create index indexCustomerName on customers (customerName);
# 创建customers中Số điện thoại的索引
create index indexCustomerPhoneNumber on customers (customerPhoneNumber);
# 创建customers中VIP等级的索引
create index indexCustomerVIPLevel on customers (customerVIPLevel);
# 创建orders中orderNumber和orderStatus 的混合索引 
create index indexOrderStatusNumber on orders (orderNumber, orderStatus);
# 创建roomtypeandprice中roomType和price的混合索引
create index indexRoomTypePrice on roomtypeandprice (roomType, price);



# 插入服务员
INSERT INTO `waiter` VALUES ('dnpcuong', 'Dương Nguyễn Phú Cường', '1989-06-11', '362209685', '1234', '2018-01-01', '0915659223', '');
INSERT INTO `waiter` VALUES ('lhsang', 'Lưu Hoài Sang', '1998-10-22', '362209684', '1234', '2017-12-06', '0909123456', '');
INSERT INTO `waiter` VALUES ('mtcnhung', 'Mai Thị Cẩm Nhung', '2017-12-28', '362209475', '1234', '2018-01-04', '0914785231', NULL);
INSERT INTO `waiter` VALUES ('tkadung', 'Tống Kim Anh Dũng', '2017-12-21', '362207485', '1234', '2017-12-05', '0914256842', NULL);
INSERT INTO `waiter` VALUES ('user1', 'user1', '2018-01-03', '362207480', '1234', '2018-01-17', '0914256844', '');
INSERT INTO `waiter` VALUES ('mm', 'nn', '1992-01-01', '362207489', '1234', '2018-01-01', '0914256847', '');


# 插入VIP等级以及对应的折扣和消费金额
INSERT INTO `viplevel` VALUES (1, 0.99, 200, NULL);
INSERT INTO `viplevel` VALUES (2, 0.98, 500, NULL);
INSERT INTO `viplevel` VALUES (3, 0.97, 1000, NULL);
INSERT INTO `viplevel` VALUES (4, 0.96, 2000, NULL);
INSERT INTO `viplevel` VALUES (5, 0.95, 3000, NULL);
INSERT INTO `viplevel` VALUES (6, 0.94, 5000, NULL);


# 插入Quản trị Hệ thống
INSERT INTO `systemadministrator` VALUES ('admin', 'Quản trị Hệ thống', '1234');

#插入房间详细信息
INSERT INTO `roomtypeandprice` VALUES ('Doanh_nhân (Đơn / Đôi)', 318, 'Rộng 18-20㎡ | giườn 1.8m | Lầu：2-4 | Có ban công', '/images/5.jpg');
INSERT INTO `roomtypeandprice` VALUES ('Nữ hoàng (Đơn / Đôi)', 188, 'Rộng 12㎡ | Giường đôi 1.5m | Lầu：2-4 | Có ban công', '/images/4.jpg');
INSERT INTO `roomtypeandprice` VALUES ('Tiêu_chuẩn (Đơn)', 178, 'Phòng: 18m2 | Giường 1.2m | Lầu: 1 | Có ban công', '/images/2.jpg');
INSERT INTO `roomtypeandprice` VALUES ('Tiêu_chuẩn (Đôi)', 258, 'Phòng 20-25㎡ | 2 giường, mỗi giường 1.2m | Lầu：2-4 | Có ban công', '/images/1.jpg');
INSERT INTO `roomtypeandprice` VALUES ('VIP (Đơn / Đôi)', 450, 'Phòng: 16-20m2 | Giường 1.5m | Lầu: 2-5 | có ban công, tivi, tủ lạnh', '/images/3.jpg');


#插入房间编号类型和Tình trạng信息
INSERT INTO `room` VALUES ('000001', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000002', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000003', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000004', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000005', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000006', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000007', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000008', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000009', 'Tiêu_chuẩn (Đơn)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000010', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000011', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000012', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000013', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000014', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000015', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000016', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000017', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000018', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000019', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000020', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000021', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000022', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000023', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000024', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000025', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000026', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000027', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000028', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000029', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000030', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000031', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000032', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000033', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000034', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000035', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000036', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000037', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000038', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000039', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000040', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000041', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000042', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000043', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000044', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000045', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000046', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000047', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000048', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000049', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000050', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000051', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000052', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000053', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000054', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000055', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000056', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000057', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000058', 'Doanh_nhân (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000059', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000060', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000061', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000062', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000063', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000064', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000065', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000066', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000067', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000068', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000069', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000070', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000071', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000072', 'Doanh_nhân (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000073', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000074', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000075', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000076', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000077', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000078', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000079', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000080', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000081', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000082', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000083', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000084', 'Nữ hoàng (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000085', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000086', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000087', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000088', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000089', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000090', 'VIP (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000091', 'Tiêu_chuẩn (Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000092', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000093', 'Doanh_nhân (Đơn / Đôi)', 'đã_có_người_thuê', NULL);
INSERT INTO `room` VALUES ('000094', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000095', 'Tiêu_chuẩn (Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000096', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000097', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000098', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000099', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000100', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000101', 'Nữ hoàng (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('000102', 'Tiêu_chuẩn (Đơn)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('001188', 'VIP (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('012341', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', NULL);
INSERT INTO `room` VALUES ('100000', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', '');
INSERT INTO `room` VALUES ('123422', 'Doanh_nhân (Đơn / Đôi)', 'còn_trống', '');


# 创建用户 
grant all on * to system IDENTIFIED by '1234' ;
	
grant SELECT,INSERT on timeextension to hotel IDENTIFIED by '1234';
grant all on room to hotel  ;
GRANT select ,INSERT on orders to hotel ; 
GRANT select ,INSERT ,UPDATE on ordertracking to hotel ; 
GRANT select,INSERT  on customers to hotel  ;
grant all on roomtypeandprice to hotel ;
GRANT select on viplevel  to hotel  ;
grant select on timeextensionordersview to hotel ;
grant select on orderviews to hotel ;
grant INSERT,UPDATE,SELECT on orders to hotel ;



