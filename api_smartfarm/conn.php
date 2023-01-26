<?php
    $conn = mysqli_connect("localhost","chiangrai","!2SRl3Z5Kpge4]") or die("ไม่สามารถเชื่อมต่อฐานเข้ามูลได้");
    mysqli_select_db($conn,"chiangrai_smartfarm") or die("ไม่พบฐานข้อมูล");
    mysqli_query($conn,"SET NAMES UTF8");
?>