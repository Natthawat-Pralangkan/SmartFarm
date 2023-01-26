<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $gh_id  = $_GET['gh_id'];
        $chack = mysqli_query($conn, "SELECT *  FROM tb_greenhouse WHERE  gh_id  = '$gh_id' ");
        $count = mysqli_num_rows($chack);
        If($count>0){
            $result = mysqli_query($conn, "DELETE FROM tb_greenhouse WHERE gh_id  = '$gh_id'");
            echo "true";
        }else {           
            echo "No data";
        }
    } 
}  // if2// if1
mysqli_close($conn);
?>
