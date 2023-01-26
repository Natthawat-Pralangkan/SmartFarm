<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
$crop_id = $_GET['crop_id'];
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $chack = mysqli_query($conn, "SELECT *  FROM tb_crop WHERE  crop_id = '$crop_id' ");
        $count = mysqli_num_rows($chack);
        If($count>0){
            $result = mysqli_query($conn, "DELETE FROM tb_crop WHERE crop_id = '$crop_id'");
            echo "true";
        }else {           
            echo "No data";
        }
    } 
}  // if2// if1
mysqli_close($conn);
?>
