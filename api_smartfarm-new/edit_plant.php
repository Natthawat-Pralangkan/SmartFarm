<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $plant_id = $_GET['plant_id'];
        $plant_name = $_GET['plant_name'];
        $age = $_GET['age'];
        $ph = $_GET['ph'];
        $temp_max = $_GET['temp_max'];
        $temp_min = $_GET['temp_min'];


        $sql = "UPDATE tb_plant SET plant_name = '$plant_name', age = '$age', ph = '$ph',temp_max ='$temp_max',temp_min ='$temp_min'  WHERE plant_id = '$plant_id'";
        $result = mysqli_query($conn, $sql);
        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome Master UNG";
}
mysqli_close($conn);
