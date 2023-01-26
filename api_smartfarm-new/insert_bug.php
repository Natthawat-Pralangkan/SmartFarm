<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $id = $_GET['bug_id']; 
        $name = $_GET['bug_name'];
        $farm_id = $_GET['farm_id'];
       
        
        $chack = mysqli_query($conn, "SELECT * FROM tb_bug WHERE bug_id  = '$id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_bug (bug_id,bug_name,farm_id) VALUE ('$id','$name','$farm_id')");
            if($result){
                echo "true";
            }else{
                echo "false";
            }
        }
    } 
}  
mysqli_close($conn);
