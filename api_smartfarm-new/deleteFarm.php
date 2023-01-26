<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
$farm_ID = $_GET['farm_id'];
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {       
        $farm_ID = $_GET['farm_id'];
        $chack = mysqli_query($conn, "SELECT *  FROM tb_farm WHERE  farm_id = '$farm_ID' ");
        $count = mysqli_num_rows($chack);
        If($count>0){
            $result = mysqli_query($conn, "DELETE FROM tb_farm WHERE farm_id = '$farm_ID'");
            echo "true";
        }else {           
            echo "No data";
        }
    } 
}  // if2// if1
mysqli_close($conn);
?>