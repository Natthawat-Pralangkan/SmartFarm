<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $result = mysqli_query($conn, "SELECT * FROM tb_diesease ");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[]= array(
                    "farm_id"=>$row['farm_id'],
                    "diesease_id "=>$row['diesease_id'],
                    "diesease_name"=>$row['diesease_name'],
                    
                );
            }   // while
            echo json_encode($output);
        } //if
    } else if ($_GET['isAdd'] == 'item') {
        $result = mysqli_query($conn, "SELECT * FROM tb_diesease WHERE diesease_id = '".$_GET['diesease_id']."'");
        if ($result) {
            $res = mysqli_fetch_assoc($result);
            echo json_encode($res);
        } 
    }else echo "Welcome Master UNG";
}   // if1
mysqli_close($conn);
