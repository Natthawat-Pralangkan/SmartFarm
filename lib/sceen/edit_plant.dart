import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/plant_model.dart';
import 'package:smartfarm/sceen/Show_plant.dart';
import '../style/Mystyle.dart';
import '../style/dialog.dart';

class edit_plant extends StatefulWidget {
  const edit_plant({Key? key}) : super(key: key);

  @override
  State<edit_plant> createState() => _edit_plantState();
}

class _edit_plantState extends State<edit_plant> {
  // TextEditingController data_IDa = TextEditingController();
  TextEditingController edit2 = TextEditingController();
  TextEditingController edit3 = TextEditingController();
  TextEditingController edit4 = TextEditingController();
  TextEditingController edit5 = TextEditingController();
  TextEditingController edit6 = TextEditingController();
  TextEditingController edit7 = TextEditingController();
  TextEditingController edit8 = TextEditingController();
  List<PlantModel> PlantModels = [];
  Map arguments = Map();
  String data_ID = "";
  @override
  void initState() {
    getdata_by_id();
    // getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['plant_id']);
    data_ID = arguments['plant_id'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 74, 216, 8),
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: const Text(" "),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'แก้ไขข้อมูลพืช',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: const Text(
              "แก้ไขข้อมูลพืช",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_plant_id(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_plant_name(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_age(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_ph(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_temp_max(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          input_temp_min(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          inputCusbut(),
        ],
      ),
    );
  }

  // String? farm_id, farm_name, email;

  // getName() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     farm_id = preferences.getString('farm_id');
  //     farm_name = preferences.getString('farm_name');
  //     email = preferences.getString('email');
  //   });
  // }

  Widget inputCusbut() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                editdata();
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => Show_plant());
                Navigator.push(context, route);
              },
              style: ElevatedButton.styleFrom(
                primary: MyStyle().textColor,
                onPrimary: Colors.blueAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'แก้ไข',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );

  String? data_IDa = '';
  gettextdata(String? ID,
      {String? plant_name, age, ph, temp_max, temp_min, plant_id}) async {
    setState(() {
      data_IDa = ID ?? '';
      edit2.text = plant_name ?? '';
      edit3.text = age ?? '';
      edit4.text = ph ?? '';
      edit5.text = temp_max ?? '';
      edit6.text = temp_min ?? '';
      edit7.text = plant_id ?? '';
    });
  }

  Future<Null> getdata_by_id() async {
    PlantModels.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // farm_id = preferences.getString('farm_id');
    String url =
        'http://localhost/api_smartfarm-new/GetEditPlant.php?plant_id=${data_ID}&isAdd=item';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      data_IDa = data_ID;
      edit2.text = result['plant_name'];
      edit3.text = result['age'];
      edit4.text = result['ph'];
      edit5.text = result['temp_max'];
      edit6.text = result['temp_min'];
      edit7.text = result['plant_id'];
    });
  }

  Future<Null> editdata() async {
    final plant_name = edit2.text,
        age = edit3.text,
        ph = edit4.text,
        temp_max = edit5.text,
        temp_min = edit6.text,
        plant_id = edit7.text;
    String url =
        'http://localhost/api_smartfarm-new/edit_plant.php?isAdd=true&plant_id=$data_IDa&plant_name=$plant_name&age=$age&ph=$ph&temp_max=$temp_max&temp_min=$temp_min';
    await Dio().get(url).then((value) {
      print(url);
      print(value);
      if (value.toString() == 'true') {
        getdata_by_id();
        setState(() {
          edit2.text = '';
          edit3.text = '';
          edit4.text = '';
          edit5.text = '';
          edit6.text = '';
          edit7.text = '';
          
          data_IDa = '';
        });
      } else if (value.toString() == 'havedata') {
        normalDialog(context, 'มีไอดีนี้อยู่แล้วกรุณาลองใหม่');
      } else {
        // normalDialog(context, 'กรุณาลองใหม่ มีอะไร? ผิดพลาด');
      }
    });
  }

  Widget input_plant_id() => Container(
        width: 250.0,
        child: TextField(
          controller: edit7,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสพืช :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_plant_name() => Container(
        width: 250.0,
        child: TextField(
          controller: edit2,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ชื่อพืช :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_age() => Container(
        width: 250.0,
        child: TextField(
          controller: edit3,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อายุพืช :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_ph() => Container(
        width: 250.0,
        child: TextField(
          controller: edit4,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ค่า PH :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_temp_max() => Container(
        width: 250.0,
        child: TextField(
          controller: edit5,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อุหภูมิสูงสุด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_temp_min() => Container(
        width: 250.0,
        child: TextField(
          controller: edit6,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'อุหภูมิต่ำสุด :',
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
