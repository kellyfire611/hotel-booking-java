<?php
// Ensure reporting is setup correctly
mysqli_report(MYSQLI_REPORT_STRICT);

function OpenCon()
{
    $dbhost = "localhost";
    $dbuser = "root";
    $dbpass = "root";
    $db = "hotel";
    $conn = new mysqli($dbhost, $dbuser, $dbpass, $db) or die("Connect failed: %s\n" . $conn->error);

    $conn->query("SET NAMES 'utf8'"); 
    $conn->query("SET CHARACTER SET utf8");  
    $conn->query("SET SESSION collation_connection = 'utf8mb4_unicode_ci'"); 
    return $conn;
}

function CloseCon($conn)
{
    $conn->close();
}
