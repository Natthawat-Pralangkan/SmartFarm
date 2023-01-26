<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $activity_id = $_GET['activity_id']; 
        $crop_id = $_GET['crop_id']; 
        $work_date = $_GET['work_date'];
        $work_detail = $_GET['work_detail'];
        $problem = $_GET['problem']; 
        $cost = $_GET['cost']; 
        $diesease_id = $_GET['diesease_id'];
        $bug_id = $_GET['bug_id'];
        $solve_by = $_GET['solve_by'];
      

        $sql = "UPDATE tb_activity SET crop_id = '$crop_id',work_date = '$work_date' , work_detail = '$work_detail',problem = '$problem',cost = '$cost' , diesease_id = '$diesease_id',bug_id = '$bug_id',solve_by = '$solve_by'  WHERE activity_id = '$activity_id'";
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
