<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $result = mysqli_query($conn, "SELECT * FROM tb_bug WHERE ");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[]= array(
                    "bug_id"=>$row['bug_id'],
                    "bug_name"=>$row['bug_name'],
                    "farm_id"=>$row['farm_id'],
                   
                );
            }   // while
            echo json_encode($output);
        } //if
    } else if ($_GET['isAdd'] == 'item') {
        $result = mysqli_query($conn, "SELECT * FROM tb_bug WHERE bug_id = '".$_GET['bug_id']."'");
        if ($result) {
            $res = mysqli_fetch_assoc($result);
            echo json_encode($res);
        } 
    }else echo "Welcome Master UNG";
}   // if1
mysqli_close($conn);
