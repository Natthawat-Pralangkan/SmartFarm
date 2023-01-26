<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
$plant_ID = $_GET['plant_id'];
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $chack = mysqli_query($conn, "SELECT *  FROM tb_plant WHERE  plant_id = '$plant_ID' ");
        $count = mysqli_num_rows($chack);
        If($count>0){
            $result = mysqli_query($conn, "DELETE FROM tb_plant WHERE plant_id = '$plant_ID'");
            echo "true";
        }else {           
            echo "No data";
        }
    } 
}  // if2// if1
mysqli_close($conn);
?>
