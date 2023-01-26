<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $farm_id = $_GET['farm_id']; 
        $crop_id  = $_GET['crop_id']; 
        $close_date = $_GET['close_date'];
        $amount = $_GET['amount'];
        $cost = $_GET['cost'];
   

        
        $chack = mysqli_query($conn, "SELECT * FROM tb_crop_close WHERE crop_id = '$crop_id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_crop_close(farm_id,crop_id,close_date,amount,cost) VALUE('$farm_id','$crop_id','$close_date','$amount','$cost')");
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