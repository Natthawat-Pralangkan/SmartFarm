<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $id = $_GET['farm_id']; 
        $crop_id  = $_GET['crop_id']; 
        $plant_id = $_GET['plant_id'];
        $crop_date = $_GET['crop_date'];
        $gh_id = $_GET['gh_id'];

        $chack = mysqli_query($conn, "SELECT * FROM tb_crop WHERE crop_id = '$crop_id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_crop(farm_id,crop_id,plant_id,crop_date,gh_id) VALUE('$id','$crop_id','$plant_id','$crop_date','$gh_id')");
            if($result){
                echo "true";
            }else{
                echo "false";
            }
        }
    } 
}  
mysqli_close($conn);
