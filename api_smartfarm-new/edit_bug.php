<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $bug_id = $_GET['bug_id']; 
        $bug_name = $_GET['bug_name']; 
      
      

        $sql = "UPDATE tb_bug SET bug_name = '$bug_name' WHERE bug_id = '$bug_id'";
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
