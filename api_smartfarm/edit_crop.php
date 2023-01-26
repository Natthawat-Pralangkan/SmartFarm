<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $farm_id = $_REQUEST['farm_id'];
        $crop_id = $_REQUEST['crop_id'];
        $plant_id = $_REQUEST['plant_id'];
        $crop_date = $_REQUEST['crop_date'];
        $gh_id = $_REQUEST['gh_id'];

        $sql = "UPDATE tb_crop SET farm_id = '$farm_id',plant_id = '$plant_id' , crop_date = '$crop_date', gh_id = '$gh_id' WHERE crop_id = '$crop_id'";
        $result = mysqli_query($conn, $sql);
        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome Master UNG";
}
 mysqli_close($conn);
?>
