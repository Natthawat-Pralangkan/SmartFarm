import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:projectend/Screens/addmid_page.dart';
// import 'package:projectend/Screens/signup.dart';
// import 'package:projectend/model/email_model.dart';
// import 'package:projectend/utility/dialog.dart';
// import 'package:projectend/utility/main_show.dart';
// import 'package:projectend/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/home.dart';
import 'package:smartfarm/main_show.dart';
import 'package:smartfarm/model/email_model.dart';
import 'package:smartfarm/sceen/farm.dart';
import 'package:smartfarm/style/dialog.dart';
import 'package:smartfarm/style/mystyle.dart';

class Signin extends StatefulWidget {
  static const routeName = '/Signin';
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[
                  Colors.white,
                  Color.fromARGB(255, 254, 255, 255)
                ],
                center: Alignment(0, -0.3),
                radius: 1.7,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  MyStyle().ShowLogo(),
                  MyStyle().sizedbox(),
                  MyStyle().ShowTitle('SMART FARMING'),
                  MyStyle().sizedbox(),
                  emailForm(),
                  MyStyle().sizedbox(),
                  passwordForm(),
                  MyStyle().sizedbox(),
                  loginbut(),
                  SizedBox(height: 30),
                  signupButton(
                    'ลงทะเบียน/Register',
                    onPressed: () {
                      MaterialPageRoute route =
                          MaterialPageRoute(builder: (value) => Infarm());
                      Navigator.push(context, route);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton signupButton(String text, {VoidCallback? onPressed}) => TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 4, 4, 4)),
        ),
      );

  Widget loginbut() => Container(
        width: 300,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            print('email=$email,password=$password');
            if (email == null ||
                password == null ||
                email == "" ||
                password == "") {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่องค่ะ');
            } else {
              checkAuthen();
            }
          },
          style: ElevatedButton.styleFrom(
            primary: MyStyle().textColor,
            onPrimary: Colors.blueAccent,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'เข้าสู่ระบบ/Login',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        'http://chiangraismartfarm.com/APIsmartfarm/login.php?isAdd=true&email=$email&password=$password';
    try {
      //print('OK TRY');
      Response response = await Dio().get(url);
      //print(response.data);
      //print('OK RESPONSE DATA');
      var result = jsonDecode(response.data);
      var data = result;
      print(data);
      if (result == null || result.length <= 0) {
        normalDialog(
            context, 'อีเมลหรือรหัสผ่าน ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง');
      } else {
        print('Email and Password Ok');
        MaterialPageRoute route = MaterialPageRoute(builder: (value) => Home());
        Navigator.push(context, route);
        for (var map in result) {
          EmailModel emailModel = EmailModel.fromJson(map);
          if (password == emailModel.password) {
            routeTuService(MyHomePage(), emailModel);
          } else {
            normalDialog(context, 'รหัสผ่านผิดกรุณาป้อน รหัสผ่าน ให้ถูกต้อง');
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> routeTuService(Widget myWidget, EmailModel emailModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('farm_id', emailModel.farm_id!);
    preferences.setString('farm_name', emailModel.farm_name!);
    preferences.setString('email', emailModel.email!);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget emailForm() => Container(
        width: 350,
        child: TextField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ชื่อผู้ใช้งาน/Username :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 350,
        child: TextField(
          obscureText: true,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสผ่าน / Password :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
}
