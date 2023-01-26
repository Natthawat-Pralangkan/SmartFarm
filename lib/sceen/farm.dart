import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/style/Mystyle.dart';
import 'package:smartfarm/style/dialog.dart';

class Infarm extends StatefulWidget {
  const Infarm({Key? key}) : super(key: key);
  @override
  _farm createState() => _farm();
}

class _farm extends State<Infarm> {
  String? farm_id,
      farm_name,
      address,
      tumbon,
      amphur,
      province,
      email,
      password,
      typeuser,
      lat,
      Lng;

  @override
  void initState() {
    var initState = super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 74, 216, 8),
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
//MyStyle().showcrru(),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          input_farm_id(),
          input_farm_name(),
          input_address(),
          input_tumbon(),
          input_amphur(),
          input_province(),
          input_email(),
          input_password(),
          input_typeuser(),
          input_lat(),
          input_Lng(),
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
                    'farm_id=$farm_id,farm_name=$farm_name,address=$address,tumbon=$tumbon,amphur=$amphur,province=$province,email=$email,password=$password,typeuser=$typeuser,lat=$lat,Lng=$Lng');
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกID');
                  return;
                }
                if (farm_name == null || farm_name == '') {
                  normalDialog(context, 'กรุณากรอกชื่อ');
                  return;
                }
                if (address == null || address == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (tumbon == null || tumbon == '') {
                  normalDialog(context, 'กรุณากรอก lat');
                  return;
                }
                if (amphur == null || amphur == '') {
                  normalDialog(context, 'กรุณากรอกID');
                  return;
                }
                if (province == null || province == '') {
                  normalDialog(context, 'กรุณากรอกชื่อ');
                  return;
                }
                if (email == null || email == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (password == null || password == '') {
                  normalDialog(context, 'กรุณากรอก lat');
                  return;
                }
                if (typeuser == null || typeuser == '') {
                  normalDialog(context, 'กรุณากรอกID');
                  return;
                }
                if (lat == null || lat == '') {
                  normalDialog(context, 'กรุณากรอกชื่อ');
                  return;
                }
                if (Lng == null || Lng == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }

                if (farm_id == null ||
                    farm_name == null ||
                    address == null ||
                    tumbon == null ||
                    amphur == null ||
                    province == null ||
                    email == null ||
                    password == null ||
                    typeuser == null ||
                    lat == null ||
                    Lng == null ||
                    farm_id == '' ||
                    farm_name == '' ||
                    address == '' ||
                    tumbon == '' ||
                    amphur == '' ||
                    province == '' ||
                    email == '' ||
                    password == '' ||
                    typeuser == '' ||
                    lat == '' ||
                    Lng == '') {
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
        'http://localhost/api_smartfarm-new/insert_farm.php?isAdd=true&farm_id=$farm_id&farm_name=$farm_name&address=$address&tumbon=$tumbon&amphur=$amphur&province=$province&email=$email&password=$password&typeuser=$typeuser&lat=$lat&Lng=$Lng';
    try {
      Response response = await Dio().get(url);
      print(response.toString() == "true");
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(
            context, 'อีเมล์นี้ $farm_id มีคนอื่นใช้ไปแล้วกรุณาเปลี่ยนอีเมล์ใหม่');
      } else {
        Navigator.pop(context);
        normalDialog(context, 'ลงทะเบียนเรียบร้อยแล้ว');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget input_farm_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => farm_id = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสฟร์าม :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_farm_name() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => farm_name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ชื่อฟร์าม :',
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
  Widget input_address() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => address = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ที่อยู่ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_tumbon() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => tumbon = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ตำบล :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_amphur() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => amphur = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อำเภอ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_province() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => province = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'จังหวัด :',
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
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อีเมล์ :',
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
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสผ่าน :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_typeuser() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => typeuser = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ประเภท :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_lat() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => lat = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ละติจูด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_Lng() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => Lng = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ลองติจูด :',
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
