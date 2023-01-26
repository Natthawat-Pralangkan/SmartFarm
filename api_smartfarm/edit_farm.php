<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $id = $_GET['farm_id']; 
        $name = $_GET['farm_name']; 
        $lat = $_GET['lat']; 
        $lng = $_GET['lng']; 
        $sql = "UPDATE tb_farm SET farm_name = '$name', lat = '$lat', lng = '$lng' WHERE farm_id = '$id'";
        $result = mysqli_query($conn, $sql);
        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome Master UNG";
}
 mysqli_close($conn);
