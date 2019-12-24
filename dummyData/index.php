<?php
require_once 'vendor/autoload.php';

include 'db_connection.php';

use Carbon\Carbon;

$conn = OpenCon();
echo "Connected Successfully" . PHP_EOL;

// Danh sách Hotels
$sql = "select * from `hotels`";
$result = mysqli_query($conn, $sql);
$dataHotels = [];
while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $dataHotels[] = $row['hotelID'];
}

// Danh sách VipLevel
$sql = "select * from `viplevel`";
$result = mysqli_query($conn, $sql);
$dataViplevels = [];
while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $dataViplevels[] = $row['level'];
}

// Danh sách Rooms
$sql = "select * from `room`";
$result = mysqli_query($conn, $sql);
$dataRooms = [];
while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $dataRooms[] = $row['roomNumber'];
}

// Danh sách Services
$sql = "select * from `services`";
$result = mysqli_query($conn, $sql);
$dataServices = [];
while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $dataServices[] = array(
        'serviceID' => $row['serviceID'],
        'price' => $row['price']
    );
}
$dataServices[] = array(
    'serviceID' => null,
    'price' => null
);

// Danh sách Waiters
$sql = "select * from `waiter`";
$result = mysqli_query($conn, $sql);
$dataWaiters = [];
while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $dataWaiters[] = $row['waiterID'];
}

// Danh sách Giới tính
$dataGenders = ['Nam', 'Nữ'];

// Danh sách Order status
$dataOrderStatus = ['Đã_thanh_toán', 'Đã_đăng_ký'];

// Tạo dữ liệu khách hàng giả
$faker = Faker\Factory::create();

for ($i = 0; $i < 100; $i++) {
    $customerIDCard = $faker->unique()->randomNumber($nbDigits = 8);
    $customerGender = $faker->randomElement($dataGenders);
    $customerName = $faker->name();
    $customerBirthday = $faker->date();
    $customerVIPLevel = $faker->randomElement($dataViplevels);
    $customerPhoneNumber = $faker->phoneNumber;
    $totalAmount = $faker->randomNumber();
    $remarks = $faker->sentence();
    $hotelID = $faker->randomElement($dataHotels);

    $sql = "INSERT INTO customers (customerIDCard, customerGender, customerName, customerBirthday, customerVIPLevel, customerPhoneNumber, totalAmount, remarks, hotelID) VALUES ('$customerIDCard', '$customerGender', '$customerName', '$customerBirthday', $customerVIPLevel, '$customerPhoneNumber', $totalAmount, '$remarks', '$hotelID')";
    // print_r($sql);die;

    // Thực thi INSERT
    mysqli_query($conn, $sql);
}
echo 'Tao du lieu gia Customer thanh cong!' . PHP_EOL;

// Danh sách Customers
$sql = "select * from `customers`";
$result = mysqli_query($conn, $sql);
$dataCustomers = [];
while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $dataCustomers[] = array(
        'customerIDCard' => $row['customerIDCard'],
        'hotelID' => $row['hotelID']
    );
}
//print_r($dataCustomers);
// print_r($faker->randomElement($dataCustomers));
// die;

// Tạo dữ liệu Đơn hàng giả
try {
    for ($i = 0; $i < 50; $i++) {
        $orderNumber = $faker->unique()->randomNumber($nbDigits = 8);
        $orderStatus = $faker->randomElement($dataOrderStatus);

        $customer = $faker->randomElement($dataCustomers);
        $customerIDCard = $customer['customerIDCard'];
        $roomNumber = $faker->randomElement($dataRooms);

        $checkin = $faker->dateTimeBetween('-3 months');
        $checkInTime = $checkin->format('Y-m-d H:i:s');
        $checkOutTime = $faker->dateTimeBetween($checkin, '+3 months')->format('Y-m-d H:i:s');
        $totalMoney = $faker->randomNumber();
        $waiterID = $faker->randomElement($dataWaiters);
        $remarks = $faker->sentence();
        $orderTime = $checkin->format('Y-m-d H:i:s');
        $hotelID = $customer['hotelID'];

        $s1 = $faker->randomElement($dataServices);
        $serviceID_1 = empty($s1) ? NULL : $s1['serviceID'];
        $price_1 = empty($s1) ? NULL : $s1['price'];

        $s2 = $faker->randomElement($dataServices);
        $serviceID_2 = empty($s2) ? NULL : $s2['serviceID'];
        $price_2 = empty($s2) ? NULL : $s2['price'];

        $s3 = $faker->randomElement($dataServices);
        $serviceID_3 = empty($s3) ? NULL : $s3['serviceID'];
        $price_3 = empty($s3) ? NULL : $s3['price'];

        // print_r($checkInTime);die;

        $sql = "INSERT INTO orders (orderNumber, orderStatus, customerIDCard, roomNumber, checkInTime, checkOutTime, totalMoney, waiterID, remarks, orderTime, hotelID,serviceID_1,price_1,serviceID_2,price_2,serviceID_3,price_3) VALUES ('$orderNumber', '$orderStatus', '$customerIDCard', '$roomNumber', '$checkInTime', '$checkOutTime', $totalMoney, '$waiterID', '$remarks', '$orderTime', '$hotelID', $serviceID_1, $price_1, $serviceID_2, $price_2, $serviceID_3, $price_3)";
        // print_r($sql);die;

        // Thực thi INSERT
        mysqli_query($conn, $sql);
    }
} catch (Exception $e) {
    echo $e->getMessage();
} catch (mysqli_sql_exception $e) {
    echo $e->getMessage();
}
echo 'Tao du lieu gia Don hang thanh cong!' . PHP_EOL;

// Danh sách Orders
// $sql = "select * from `orders`";
// $result = mysqli_query($conn, $sql);
// $dataOrders = [];
// while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
//     $dataOrders[] = $row['orderNumber'];
// }



CloseCon($conn);
