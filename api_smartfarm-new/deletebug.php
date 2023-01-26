<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
$bug_id  = $_GET['bug_id'];
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $chack = mysqli_query($conn, "SELECT *  FROM tb_bug WHERE  bug_id  = '$bug_id ' ");
        $count = mysqli_num_rows($chack);
        If($count>0){
            $result = mysqli_query($conn, "DELETE FROM tb_bug WHERE bug_id  = '$bug_id '");
            echo "true";
        }else {           
            echo "No data";
        }
    } 
}  // if2// if1
mysqli_close($conn);
?>
