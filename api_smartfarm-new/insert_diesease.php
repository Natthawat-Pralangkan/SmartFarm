<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $diesease_id  = $_GET['diesease_id']; 
        $diesease_name = $_GET['diesease_name'];
        $farm_id = $_GET['farm_id'];


        
        $chack = mysqli_query($conn, "SELECT * FROM tb_diesease WHERE diesease_id = '$diesease_id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_diesease(diesease_id,diesease_name,farm_id) VALUE('$diesease_id','$diesease_name','$farm_id')");
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