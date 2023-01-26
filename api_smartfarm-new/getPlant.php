<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $result = mysqli_query($conn, "SELECT * FROM tb_plant WHERE farm_id = '".$_GET['farm_id']."'");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[]= array(
                    "farm_id"=>$row['farm_id'],
                    "plant_id"=>$row['plant_id'],
                    "plant_name"=>$row['plant_name'],
                    "age"=>$row['age'],
                    "ph"=>$row['ph'],
                    "temp_max"=>$row['temp_max'],
                    "temp_min"=>$row['temp_min'],
                    // "soild_moisture"=>$row['soild_moisture'],
                );
            }   // while
            echo json_encode($output);
        } //if
    } else if ($_GET['isAdd'] == 'item') {
        $result = mysqli_query($conn, "SELECT * FROM tb_plant WHERE farm_id = '".$_GET['farm_id']."'");
        if ($result) {
            $res = mysqli_fetch_assoc($result);
            echo json_encode($res);
        } 
    }else echo "Welcome Master UNG";
}   // if1
mysqli_close($conn);
?>