<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $farm_id = $_GET['farm_id']; 
        $farm_name = $_GET['farm_name']; 
        $address = $_GET['address'];
        $tumbon = $_GET['tumbon'];
        $amphur = $_GET['amphur']; 
        $province = $_GET['province']; 
        $email = $_GET['email'];
        $password = $_GET['password'];
        $typeuser = $_GET['typeuser']; 
        $lat = $_GET['lat'];
        $Lng = $_GET['Lng'];
        $chack = mysqli_query($conn, "SELECT * FROM tb_user WHERE farm_id = '$farm_id' ");
        $count = mysqli_num_rows($chack);
        if($count>0){
            echo "havedata";
        }else {
            $result = mysqli_query($conn, "INSERT INTO tb_user(farm_id,farm_name,address,tumbon,amphur,province,email,password,typeuser,lat,Lng) VALUE('$farm_id','$farm_name','$address','$tumbon','$amphur','$province','$email','$password','$typeuser','$lat','$Lng')");
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