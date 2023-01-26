<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $result = mysqli_query($conn, "SELECT * FROM tb_activity ");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[]= array(
                    "activity_id"=>$row['activity_id'],
                    "crop_id"=>$row['crop_id'],
                    "work_date"=>$row['work_date'],
                    "work_detail"=>$row['work_detail'],
                    "problem"=>$row['problem'],
                    "cost"=>$row['cost'],
                    "diesease_id"=>$row['diesease_id'],
                    "bug_id"=>$row['bug_id'],
                    "solve_by"=>$row['solve_by'],
                    "farm_id"=>$row['farm_id'],
                    // "soild_moisture"=>$row['soild_moisture'],
                );
            }   // while
            echo json_encode($output);
        } //if
    } else if ($_GET['isAdd'] == 'item') {
        $result = mysqli_query($conn, "SELECT * FROM tb_activity WHERE activity_id = '".$_GET['activity_id']."'");
        if ($result) {
            $res = mysqli_fetch_assoc($result);
            echo json_encode($res);
        } 
    }else echo "Welcome Master UNG";
}   // if1
mysqli_close($conn);
?>