<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $activity_id  = $_GET['activity_id']; 
        $crop_id = $_GET['crop_id']; 
        $work_date = $_GET['work_date'];
        $work_detail = $_GET['work_detail'];
        $problem = $_GET['problem']; 
        $cost = $_GET['cost'];
        $diesease_id = $_GET['diesease_id'];
        $bug_id = $_GET['bug_id'];
        $solve_by = $_GET['solve_by'];
        $farm_id = $_GET['farm_id'];

        // $soild_moisture = $_GET['soild_moisture'];
        
        $chack = mysqli_query($conn, "SELECT * FROM tb_activity WHERE activity_id = '$activity_id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_activity(activity_id,crop_id,work_date,work_detail,problem,cost,diesease_id,bug_id,solve_by,farm_id) VALUE('$activity_id','$crop_id','$work_date','$work_detail','$problem','$cost','$diesease_id','$bug_id','$solve_by','$farm_id')");
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