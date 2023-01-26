import 'dart:convert';
import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/crop_model.dart';

import 'package:smartfarm/style/Mystyle.dart';
import 'package:smartfarm/style/dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../model/crop_close_model.dart';

class crop_close extends StatefulWidget {
  const crop_close({Key? key}) : super(key: key);
  @override
  _crop_close createState() => _crop_close();
}

class _crop_close extends State<crop_close> {
  String? crop_id, close_date, amount, cost;
  List categoryItemlist = [];

  String? farm_id, farm_name, email;
  List<CropModel> cropModel = [];
  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id = preferences.getString('farm_id');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

  bool readdata = false;
  getCloseCrop() async {
    // Showlist();
    cropModel.clear();
    print(cropModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://localhost/api_smartfarm-new/getCrop.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    print('===>$response');
    var result = json.decode(response.data);
    print(result.toString());
    if (result.toString() != 'null') {
      //print(result.toString());
      for (var map in result) {
        CropModel cropModels = CropModel.fromJson(map);
        setState(() {
          cropModel.add(cropModels);
          readdata = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlist = jsonData;
            });
          }
        });
      }
      //print(jsonEncode(CropModels));
    } else {
      setState(() {
        cropModel = [];
        readdata = false;
      });
    }
  }

  @override
  void initState() {
    var initState = super.initState();
    getCloseCrop();
  }

  var dropdownvalue;
  var valuedate;

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
          input_crop_id(),
          input_close_date(),
          input_amount(),
          input_cost(),
          signupbut(),
          // dropdown(),
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
                    'close_date=$valuedate,amount=$amount,cost=$cost,crop_id=$dropdownvalue,farm_id=$farm_id');
                if (dropdownvalue == null || dropdownvalue == '') {
                  normalDialog(context, 'กรุณากรอกวันที่ปลูก');
                  return;
                }

                if (valuedate == null || valuedate == '') {
                  normalDialog(context, 'กรุณากรอกรหัสพืช');
                  return;
                }
                if (amount == null || amount == '') {
                  normalDialog(context, 'กรุณากรอกวันที่ปลูก');
                  return;
                }
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสฟร์าม');
                  return;
                }

                if (cost == null || cost == '') {
                  normalDialog(context, 'กรุณากรอกรหัสพืช');
                  return;
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
                'บันทึก',
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
        'http://localhost/api_smartfarm-new/insert_crop_close.php?isAdd=true&&close_date=$valuedate&amount=$amount&cost=$cost&crop_id=$dropdownvalue&farm_id=$farm_id';
    try {
      Response response = await Dio().get(url);
      print(response.statusCode);
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context, 'มีไอดีนี้แล้ว $crop_id ');
      } else {
        Navigator.pop(context);
        normalDialog(context, 'บันทึกเรียบร้อยแล้ว');
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
  Widget input_crop_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสรอบปลูก',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlist.map((item) {
              return DropdownMenuItem(
                value: item['crop_id'].toString(),
                child: Text(item['crop_id'].toString()),
              );
            }).toList(),
            value: dropdownvalue,
            // onChanged: (newVal) {
            //   setState(() {
            //     dropdownvalue = newVal as String;
            //   });
            // },

            onChanged: (newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
              //  print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );

  Widget input_close_date() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'วันที่เก็บเกี่ยว',
              ),
              firstDate: DateTime.now().add(const Duration(days: 10)),
              lastDate: DateTime.now().add(const Duration(days: 40)),
              initialDate: DateTime.now().add(const Duration(days: 20)),
              autovalidateMode: AutovalidateMode.always,
              validator: (DateTime? e) =>
                  (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {
                print(value.toString());
                setState(() {
                  valuedate = value.toString();
                });
              },
            ),
          ],
        ),
        // width: 250.0,
        // margin: const EdgeInsets.all(10),
        // child: TextField(
        //   onChanged: (value) => close_date = value.trim(),
        //   decoration: InputDecoration(
        //     prefixIcon: Icon(
        //       Icons.account_box,
        //       color: MyStyle().textColor,
        //     ),
        //     labelStyle: TextStyle(color: MyStyle().textColor),
        //     labelText: 'วันที่เก็บเกี่ยว :',
        //     enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(12),
        //         borderSide: BorderSide(color: MyStyle().textColor)),
        //     focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(12),
        //         borderSide: BorderSide(color: MyStyle().textColorfocus)),
        //   ),
        // ),
      );
  Widget input_amount() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => amount = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รายได้ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_cost() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => cost = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ค้นทุน :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  // Widget dropdown() => Container(
  //       width: 250.0,
  //       margin: const EdgeInsets.all(10),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           DropdownButton(
  //             hint: Text('hooseNumber'),
  //             items: categoryItemlist.map((item) {
  //               return DropdownMenuItem(
  //                 value: item['crop_id'].toString(),
  //                 child: Text(item['crop_id'].toString()),
  //               );
  //             }).toList(),
  //             onChanged: (newVal) {
  //               setState(() {
  //                 dropdownvalue = newVal;
  //               });
  //             },
  //             value: dropdownvalue,
  //           ),
  //         ],
  //       ),
  //     );
}
