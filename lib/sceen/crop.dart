import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/greenhouse_model.dart';
import 'package:smartfarm/model/plant_model.dart';
import 'package:smartfarm/style/Mystyle.dart';
import 'package:smartfarm/style/dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class crop extends StatefulWidget {
  const crop({Key? key}) : super(key: key);
  @override
  _crop createState() => _crop();
}

class _crop extends State<crop> {
  String? farm_id, plant_id, crop_date, crop_id, gh_id, farm_name, email;
  List<PlantModel> PlantModels = [];
  List<GreehouseModel> greehouseModel = [];
  List categoryItemlist = [];
  List categoryItemlistgh_id = [];
  TextEditingController _date = TextEditingController();
  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id = preferences.getString('farm_id');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

/////////////////////////////getPlant//////////////////////////////////////////////////////
  bool readdata = false;
  getplant() async {
    PlantModels.clear();
    print(PlantModels);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getPlant.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responseplant_id==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        PlantModel plantModel = PlantModel.fromJson(map);
        setState(() {
          PlantModels.add(plantModel);
          readdata = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlist = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(PlantModels));
    } else {
      setState(() {
        PlantModels = [];
        readdata = false;
      });
    }
  }

// ////////////////////////////////////////////////////////////////////////////
  bool readdata1 = false;
  getgreenhouse() async {
    greehouseModel.clear();
    print(greehouseModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getGreenhouse.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responsegh_id==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        GreehouseModel greehouseModels = GreehouseModel.fromJson(map);
        setState(() {
          greehouseModel.add(greehouseModels);
          readdata1 = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlistgh_id = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(Model));
    } else {
      setState(() {
        greehouseModel = [];
        readdata1 = false;
      });
    }
  }

//////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    var initState = super.initState();
    getplant();
    getName();
    getgreenhouse();
  }

  var dropdownvalue;
  var dropdownvaluegh_id;
  var value;
  var valuedate;
  DateTime? selectedDate;
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
          input_plant_id(),
          input_crop_date(),
          input_gh_id(),
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
                    'farm_id=$farm_id,plant_id=$dropdownvalue,crop_date=$valuedate,crop_id=$crop_id,gh_id=$dropdownvaluegh_id');
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกวันที่ปลูก');
                  return;
                }

                if (crop_id == null || crop_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสพืช');
                  return;
                }

                if (dropdownvalue == null || dropdownvalue == '') {
                  normalDialog(context, 'กรุณากรอกรหัสพืช');
                  return;
                }
                if (dropdownvaluegh_id == null || dropdownvaluegh_id == '') {
                  normalDialog(context, 'กรุณากรอกรหัสพืช');
                  return;
                }
                if (valuedate == null || valuedate == '') {
                  normalDialog(context, 'กรุณากรอกรหัสโรงเรือน');
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
        'http://chiangraismartfarm.com/APIsmartfarm/insert_crop.php?isAdd=true&farm_id=$farm_id&plant_id=$dropdownvalue&crop_date=$valuedate&gh_id=$dropdownvaluegh_id&crop_id=$crop_id';
    try {
      Response response = await Dio().get(url);
      print(response.statusCode );
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context, 'มีไอดีนี้แล้ว $farm_id ');
      } else {
        Navigator.pop(context);
        normalDialog(context, 'บันทึกเรียบร้อยแล้ว');
      }
    } catch (e) {
      print(url);
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
        child: TextField(
          onChanged: (value) => crop_id = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รหัสรอบการปลูก :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_plant_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสพืช',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlist.map((item) {
              return DropdownMenuItem(
                value: item['plant_id'].toString(),
                child: Text(item['plant_name'].toString()),
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

  Widget input_gh_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสโรงเรียน',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlistgh_id.map((item1) {
              return DropdownMenuItem(
                value: item1['gh_id'].toString(),
                child: Text(item1['gh_name'].toString()),
              );
            }).toList(),
            value: dropdownvaluegh_id,
            onChanged: (newVal) {
              setState(() {
                dropdownvaluegh_id = newVal as String;
              });
              //  print(dropdownvaluegh_id);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );
  Widget input_crop_date() => Container(
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
                labelText: 'วันที่เริ่มปลูก',
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
      );

  // child: TextField(
  //   onChanged: (value) => crop_date = value.trim(),
  //   decoration: InputDecoration(
  //     prefixIcon: Icon(
  //       Icons.account_box,
  //       color: MyStyle().textColor,
  //     ),
  //     labelStyle: TextStyle(color: MyStyle().textColor),
  //     labelText: 'วันที่เริ่มปลูก :',
  //     enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: MyStyle().textColor)),
  //     focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: BorderSide(color: MyStyle().textColorfocus)),
  //   ),
  // ),

}
