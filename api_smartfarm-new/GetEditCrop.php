<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $result = mysqli_query($conn, "SELECT * FROM tb_crop ");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[]= array(
                    "crop_id"=>$row['crop_id'],
                    "crop_date"=>$row['crop_date'],
                    "plant_id"=>$row['plant_id'],
                    "farm_id"=>$row['farm_id'],
                    "gh_id"=>$row['gh_id'],
                );
            }   // while
            echo json_encode($output);
        } //if
    } else if ($_GET['isAdd'] == 'item') {
        $result = mysqli_query($conn, "SELECT * FROM tb_crop WHERE crop_id = '".$_GET['crop_id']."'");
        if ($result) {
            $res = mysqli_fetch_assoc($result);
            echo json_encode($res);
        } 
    }else echo "Welcome Master UNG";
}   // if1
mysqli_close($conn);
?>
