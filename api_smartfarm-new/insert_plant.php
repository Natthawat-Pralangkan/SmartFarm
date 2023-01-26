<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $id = $_GET['plant_id']; 
        $name = $_GET['plant_name']; 
        $age = $_GET['age'];
        $ph = $_GET['ph'];
        $temp_max = $_GET['temp_max']; 
        $temp_min = $_GET['temp_min'];
        $farm_id = $_GET['farm_id'];

        // $soild_moisture = $_GET['soild_moisture'];
        
        $chack = mysqli_query($conn, "SELECT * FROM tb_plant WHERE plant_id = '$id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_plant(plant_id,plant_name,age,ph,temp_max,temp_min,farm_id) VALUE('$id','$name','$age','$ph','$temp_max','$temp_min','$farm_id')");
            if($result){
                echo "true";
            }else{
                echo "false";
            }
        }
    } 
}  
mysqli_close($conn);
?>