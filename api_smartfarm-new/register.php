<?php
header('Access-Control-Allow-Origin: *');
include("conn.php");
$name = $_REQUEST['name'];
$email = $_REQUEST['email'];
$phonenumber = $_REQUEST['phonenumber'];
$password = $_REQUEST['password'];
$id = $_REQUEST['user_id'];
$no=1;
$newCode=1;
//=== คำนวณหาเลขที่ ID ล่าสุด ===
$sql ="SELECT MAX(user_id) AS MAX_ID FROM tb_user ";
$objQuery = mysqli_query($conn,$sql)or die(mysqli_error($conn,$sql));
while($row1 = mysqli_fetch_array($objQuery))
{
    if ($row1["MAX_ID"]!="")
    {
        $no = $row1["MAX_ID"];
    }
}
$newno = "0000".(string)$no;
$newno = substr($id,-5);
$newuserid = $newno;
$sql = "insert into tb_user(user_id,name,email,phonenumber,password)
values('$newuserid','$name','$email','$phonenumber','$password')";
echo $sql;
mysqli_query($conn,$sql);
echo"<script language='javascript'>alert('ทำการบันทึกข้อมูลสำเร็จแล้ว'); </script>";
?>