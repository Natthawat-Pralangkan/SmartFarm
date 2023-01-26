<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $crop_id = $_GET['crop_id']; 
        $close_date = $_GET['close_date']; 
        $amount = $_GET['amount'];
        $cost = $_GET['cost'];
      

        $sql = "UPDATE tb_crop_close SET close_date = '$close_date',amount = '$amount' , cost = '$cost' WHERE crop_id = '$crop_id'";
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
