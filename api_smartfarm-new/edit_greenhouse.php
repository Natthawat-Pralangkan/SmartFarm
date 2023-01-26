<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $farm_id = $_GET['farm_id'];
        $gh_id = $_GET['gh_id'];
        $gh_name = $_GET['gh_name'];
        $gh_status = $_GET['gh_status'];
        $sql = "UPDATE tb_greenhouse SET farm_id = '$farm_id',gh_name = '$gh_name',gh_status = '$gh_status' WHERE gh_id = '$gh_id'";
        $result = mysqli_query($conn, $sql);
        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome Master UNG";
}
mysqli_close($conn);
