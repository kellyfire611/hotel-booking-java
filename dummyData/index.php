<?php
include 'db_connection.php';
$conn = OpenCon();
echo "Connected Successfully";

// Danh sách Hotels
$sql = "select * from `hotels`";
$result = mysqli_query($conn, $sql);
$dataHotels = [];
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
{
    $dataHotels[] = $row['hotelID'];
}

// Danh sách VipLevel
$sql = "select * from `viplevel`";
$result = mysqli_query($conn, $sql);
$dataViplevels = [];
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
{
    $dataViplevels[] = $row['level'];
}

// Danh sách Rooms
$sql = "select * from `room`";
$result = mysqli_query($conn, $sql);
$dataRooms = [];
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
{
    $dataRooms[] = $row['roomNumber'];
}

// Danh sách Services
$sql = "select * from `services`";
$result = mysqli_query($conn, $sql);
$dataServices = [];
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
{
    $dataServices[] = $row['serviceID'];
}

// Danh sách Waiters
$sql = "select * from `waiter`";
$result = mysqli_query($conn, $sql);
$dataWaiters = [];
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
{
    $dataWaiters[] = $row['waiterID'];
}

// Danh sách Giới tính
$dataGenders = ['Nam', 'Nữ'];

// Tạo dữ liệu khách hàng giả
$faker = Faker\Factory::create();
for($i = 0; $i < 100; $i++) {
    $customerIDCard = $faker->randomNumber(11);
    $customerGender = $faker->randomElement($dataGenders);
    $customerName = $faker->name();
    $customerBirthday = $faker->date();
    $customerVIPLevel = $faker->randomElement($dataViplevels);
    $customerPhoneNumber = $faker->phoneNumber;
    $totalAmount = $faker->randomNumber();
    $remarks = $faker->sentence();
    $hotelID = $faker->randomElement($dataHotels);

    $sql = "INSERT INTO customers (customerIDCard, customerGender, customerName, customerBirthday, customerVIPLevel, customerPhoneNumber, totalAmount, remarks, hotelID) VALUES ('$customerIDCard', '$customerGender', '$customerName', '$customerBirthday', $customerVIPLevel, $customerPhoneNumber, $totalAmount, $remarks, $hotelID)";

    // Thực thi INSERT
    mysqli_query($conn, $sql);
}


CloseCon($conn);
