<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $id = $_GET['farm_id']; 
        $gh_id  = $_GET['gh_id']; 
        $gh_name = $_GET['gh_name'];
        $gh_status = $_GET['gh_status'];
   
        
        $chack = mysqli_query($conn, "SELECT * FROM tb_greenhouse WHERE gh_id = '$gh_id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_greenhouse(farm_id,gh_id,gh_name,gh_status) VALUE('$id','$gh_id','$gh_name','$gh_status')");
            if($result){
                echo "true";
            }else{
                echo "false";
            }
        }
    } 
}  
mysqli_close($conn);
