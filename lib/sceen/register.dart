import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/style/dialog.dart';
import 'package:smartfarm/style/mystyle.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? user_id, name, email, phonenumber, password;

  double? lat, lng;

  @override
  void initState() {
    var initState = super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 237, 54, 124),
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
//MyStyle().showcrru(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'ลงทะเบียน/Register',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          MyStyle().ShowLogo(),
          input_Userid(),
          input_name(),
          input_phonenumber(),
          input_email(),
          input_password(),
          signupbut(),
        ],
      ),
    );
  }

  Widget signupbut() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                print(
                    'user_id=$user_id,name=$name,password=$password,email=$email,phonenumber=$phonenumber');
                if (user_id == null || user_id == '') {
                  normalDialog(context, 'กรุณากรอกID');
                  return;
                }
                if (name == null || name == '') {
                  normalDialog(context, 'กรุณากรอกชื่อ');
                  return;
                }
                if (phonenumber == null || phonenumber == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (email == null || email == '') {
                  normalDialog(context, 'กรุณากรอก Email');
                  return;
                }
                if (password == null || password == '') {
                  normalDialog(context, 'กรุณากรอก password');
                  return;
                }
                if (name == null ||
                    email == null ||
                    user_id == null ||
                    password == null ||
                    phonenumber == null ||
                    name == '' ||
                    email == '' ||
                    user_id == '' ||
                    password == '' ||
                    phonenumber == '') {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
                } else {
                  CheckUser();
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
                'ลงทะเบียน',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );

  Future<void> CheckUser() async {
    String url =
        'http://localhost/api_smartfarm-new/register.php?isAdd=true&user_id=$user_id&name=$name&email=$email&phonenumber=$phonenumber&password=$password';
    try {
      Response response = await Dio().get(url);
      print(response.toString() == "true");
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context,
            'อีเมล์นี้ $email มีคนอื่นใช้ไปแล้วกรุณาเปลี่ยนอีเมล์ใหม่');
      } else {
        Navigator.pop(context);
        normalDialog(context, 'ลงทะเบียนเรียบร้อยแล้ว');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget input_Userid() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user_id = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'user_id :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_password() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'password :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_email() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'email :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

//================= เริ่มสร้าง Field =============
  Widget input_phonenumber() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => phonenumber = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'phonenumber :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_name() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'name :',
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
