import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/activity_model.dart';
import 'package:smartfarm/model/bug_modeel.dart';
import 'package:smartfarm/model/crop_model.dart';
import 'package:smartfarm/model/diesease_model.dart';
import 'package:smartfarm/style/Mystyle.dart';
import 'package:smartfarm/style/dialog.dart';

class activity extends StatefulWidget {
  const activity({Key? key}) : super(key: key);
  @override
  _activity createState() => _activity();
}

class _activity extends State<activity> {
  String? crop_id,
      work_date,
      work_detail,
      problem,
      cost,
      diesease_id,
      bug_id,
      activity_id,
      solve_by;
  String? farm_id, farm_name, email;
  List<CropModel> cropModel = [];
  List<DieseaseModel> dieseaseModel = [];
  List<bugModel> BugModel = [];
  // TextEditingController greenhousenumber = TextEditingController();
  List categoryItemlist = [];
  List categoryItemlistdiesease = [];
  List categoryItemlistbug = [];
  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id = preferences.getString('farm_id');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

//////////////////////////////////////////////getCrop////////////////////////////////
  bool readdata = false;
  getcrop() async {
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
          readdata = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlist = jsonData;
            });
          }
        });
      }
      //print(jsonEncode(Model));
    } else {
      setState(() {
        cropModel = [];
        readdata = false;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////getactivity//////////////////////////////////////////
  bool readdata1 = false;
  getdiesease() async {
    dieseaseModel.clear();
    print(dieseaseModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://localhost/api_smartfarm-new/getdiesease.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responsegh_id==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        DieseaseModel dieseaseModels = DieseaseModel.fromJson(map);
        setState(() {
          dieseaseModel.add(dieseaseModels);
          readdata1 = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlistdiesease = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(Model));
    } else {
      setState(() {
        dieseaseModel = [];
        readdata1 = false;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  bool readdatabug = false;
  getbug() async {
    BugModel.clear();
    print(BugModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://localhost/api_smartfarm-new/getbug.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('responsebug==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        bugModel BugModels = bugModel.fromJson(map);
        setState(() {
          BugModel.add(BugModels);
          readdatabug = true;
          if (response.statusCode == 200) {
            var jsonData = json.decode(response.data);
            setState(() {
              categoryItemlistbug = jsonData;
            });
          }
        });
      }
      // print(jsonEncode(Model));
    } else {
      setState(() {
        BugModel = [];
        readdatabug = false;
      });
    }
  }

///////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    var initState = super.initState();
    super.initState();
    getdiesease();
    getcrop();
    getbug();
  }

  var dropdownvalue;
  var dropdownvaluediesease;
  var dropdownvaluebug;
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
          input_activity_id(),
          input_crop_id(),
          input_work_date(),
          input_work_detail(),
          input_problem(),
          input_cost(),
          input_diesease_id(),
          input_bug_id(),
          input_solve_by(),
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
                    'crop_id=$dropdownvalue,work_date=$valuedate,work_detail=$work_detail,problem=$problem,cost=$cost,diesease_id=$dropdownvaluediesease,bug_id=$dropdownvaluebug,solve_by=$solve_by,activity_id=$activity_id,farm_id=$farm_id');
                if (dropdownvalue == null || dropdownvalue == '') {
                  normalDialog(context, 'กรุณากรอกID');
                  return;
                }
                if (valuedate == null || valuedate == '') {
                  normalDialog(context, 'กรุณากรอกชื่อ');
                  return;
                }
                if (work_detail == null || work_detail == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (problem == null || problem == '') {
                  normalDialog(context, 'กรุณากรอก lat');
                  return;
                }
                if (cost == null || cost == '') {
                  normalDialog(context, 'กรุณากรอกID');
                  return;
                }
                if (dropdownvaluediesease == null ||
                    dropdownvaluediesease == '') {
                  normalDialog(context, 'กรุณากรอกชื่อ');
                  return;
                }
                if (dropdownvaluebug == null || dropdownvaluebug == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (activity_id == null || activity_id == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, 'กรุณากรอกเบอร์โทร');
                  return;
                }
                if (solve_by == null || solve_by == '') {
                  normalDialog(context, 'กรุณากรอก lat');
                  return;
                }
                if 
                 (activity_id == null || activity_id == '') {
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
        'http://localhost/api_smartfarm-new/insert_activity.php?isAdd=true&crop_id=$dropdownvalue&work_date=$valuedate&work_detail=$work_detail&problem=$problem&cost=$cost&diesease_id=$dropdownvaluediesease&bug_id=$dropdownvaluebug&solve_by=$solve_by&activity_id=$activity_id&farm_id=$farm_id';
    try {
      Response response = await Dio().get(url);
      print(response.toString() == "true");
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context,
            'รหัสฟร์าม $crop_id มีคนอื่นใช้ไปแล้วกรุณาเปลี่ยนอีเมล์ใหม่');
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
      Widget input_activity_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => activity_id = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ยังไม่รู้ชื่อ :',
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
              'รหัสพืช',
              style: TextStyle(
                fontSize: 14,
                // color: Theme.of(context).hintColor,
                color: Colors.black,
              fontWeight: FontWeight.w500
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
              // print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
           
          ),
        ),
      );

  Widget input_work_date() => Container(
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
        //   onChanged: (value) => work_date = value.trim(),
        //   decoration: InputDecoration(
        //     prefixIcon: Icon(
        //       Icons.account_box,
        //       color: MyStyle().textColor,
        //     ),
        //     labelStyle: TextStyle(color: MyStyle().textColor),
        //     labelText: 'วันที่บันทึก :',
        //     enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(12),
        //         borderSide: BorderSide(color: MyStyle().textColor)),
        //     focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(12),
        //         borderSide: BorderSide(color: MyStyle().textColorfocus)),
        //   ),
        // ),
      );

  Widget input_work_detail() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => work_detail = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'รายละเอียด :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_problem() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => problem = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ปัญหาที่พบ :',
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
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'ค่าใช่จ่าบ :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_diesease_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสโรค',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlistdiesease.map((item1) {
              return DropdownMenuItem(
                value: item1['diesease_id'].toString(),
                child: Text(item1['diesease_name'].toString()),
              );
            }).toList(),
            value: dropdownvaluediesease,
            onChanged: (newValue) {
              setState(() {
                dropdownvaluediesease = newValue as String;
              });
              //  print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );

//================= เริ่มสร้าง Field =============
  Widget input_bug_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'รหัสศัตรูพืช',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: categoryItemlistbug.map((itembug) {
              return DropdownMenuItem(
                value: itembug['bug_id'].toString(),
                child: Text(itembug['bug_name'].toString()),
              );
            }).toList(),
            value: dropdownvaluebug,
            onChanged: (newValue) {
              setState(() {
                dropdownvaluebug = newValue as String;
              });
              //  print(dropdownvalue);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      );

  Widget input_solve_by() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => solve_by = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: 'การแก้ไขปัญหา :',
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
