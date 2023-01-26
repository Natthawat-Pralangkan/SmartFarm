<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $diesease_id  = $_GET['diesease_id']; 
        $diesease_name = $_GET['diesease_name']; 
      
      

        $sql = "UPDATE tb_diesease SET diesease_name = '$diesease_name' WHERE diesease_id = '$diesease_id'";
        $result = mysqli_query($conn, $sql);
        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome Master UNG";
}
 mysqli_close($conn);
