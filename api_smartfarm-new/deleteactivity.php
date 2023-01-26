<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
$activity_id  = $_GET['activity_id'];
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $chack = mysqli_query($conn, "SELECT *  FROM tb_activity WHERE  activity_id  = '$activity_id' ");
        $count = mysqli_num_rows($chack);
        If($count>0){
            $result = mysqli_query($conn, "DELETE FROM tb_activity WHERE activity_id  = '$activity_id'");
            echo "true";
        }else {           
            echo "No data";
        }
    } 
}  // if2// if1
mysqli_close($conn);
?>
