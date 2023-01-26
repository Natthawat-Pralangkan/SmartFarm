<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");

// $output = array();
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $email = $_GET['email'];
        $password = $_GET['password'];
        $result = mysqli_query($conn, "SELECT * FROM tb_user WHERE email = '$email' AND password = '$password'");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[] = $row;
               
            }
      
            // echo $output;
            echo json_encode($output);
        }
    } else echo "Welcome Master UNG"; // if2
} // if1
mysqli_close($conn);
