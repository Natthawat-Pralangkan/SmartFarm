import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/model/activity_model.dart';
import 'package:smartfarm/sceen/activity.dart';
import 'package:smartfarm/sceen/edit_activity.dart';
import 'package:smartfarm/sceen/edit_farm.dart';
import '../style/Mystyle.dart';
import 'farm.dart';

class Show_activity extends StatefulWidget {
  static const routeName = '/Show_activity';
  const Show_activity({Key? key}) : super(key: key);

  @override
  State<Show_activity> createState() => _Show_activityState();
}

class _Show_activityState extends State<Show_activity> {
  List<ActivityModel> activityModel = [];
  String? list;
  void initState() {
    getfarm();
    super.initState();
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
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            // MyStyle().ShowLogo(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'ข้อมูลการดูแลพืช',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
      body: ListView(padding: EdgeInsets.all(30.0), children: <Widget>[
        Row(
          children: [create()],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        // MyStyle().ShowLogo3(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: const Text(
            "ข้อมูลการดูแลพืช",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: Color.fromARGB(255, 74, 216, 8),
                fontWeight: FontWeight.bold),
          ),
        ),
        Showlist()
      ]),
    );
  }

  Widget create() => Container(
        width: 65,
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => activity());
            Navigator.push(context, route);
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 74, 216, 8),
            onPrimary: Colors.blueAccent,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'เพิ่ม',
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget Showlist() {
    return readdata
        ? Container(
            child: Container(
              margin: EdgeInsets.all(15),
              child: DataTable(
                columnSpacing: 10,
                // horizontalMargin: 15,
                columns: const <DataColumn>[
                  // DataColumn(
                  //   //width: 65,
                  //   label: Text(
                  //     'รหัสฟร์าม',
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // DataColumn(
                  //   //width: 65,
                  //   label: Text(
                  //     'รหัสการดูแลพืช',
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // DataColumn(
                  //   //width: 65,
                  //   label: Text(
                  //     'รหัสรอบการปลูก',
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  DataColumn(
                    label: Text(
                      'วันที่บันทึก',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'รายละเอียด',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ปัญหาที่พบ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ค่าใช่จ่าย',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // DataColumn(
                  //   label: Text(
                  //     'รหัสโรค',
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // DataColumn(
                  //   label: Text(
                  //     'รหัสศัตรูพืช',
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  DataColumn(
                    label: Text(
                      'การแก้ไขปัญหา',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'แก้ไขข้อมูล',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ลบข้อมูล',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: activityModel.map(
                  (activityModel) => DataRow(cells: [
                    // DataCell(
                    //   Text(
                    //     (activityModel.farm_id.toString().length > 50)
                    //         ? activityModel.farm_id.toString().substring(0, 50)
                    //         : activityModel.farm_id.toString(),
                    //   ),
                    // ),
                    // DataCell(
                    //   Text(
                    //     (activityModel.activity_id.toString().length > 50)
                    //         ? activityModel.activity_id.toString().substring(0, 50)
                    //         : activityModel.activity_id.toString(),
                    //   ),
                    // ),
                    // DataCell(
                    //   Text(
                    //     (activityModel.crop_id .toString().length > 50)
                    //         ? activityModel.crop_id .toString().substring(0, 50)
                    //         : activityModel.crop_id .toString(),
                    //   ),
                    // ),
                    
                    DataCell(
                      Text(
                        (activityModel.work_date.toString().length > 50)
                            ? activityModel.work_date.toString().substring(0, 50)
                            : activityModel.work_date.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (activityModel.work_detail.toString().length > 50)
                            ? activityModel.work_detail.toString().substring(0, 50)
                            : activityModel.work_detail.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (activityModel.problem.toString().length > 50)
                            ? activityModel.problem.toString().substring(0, 50)
                            : activityModel.problem.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (activityModel.cost.toString().length > 50)
                            ? activityModel.cost.toString().substring(0, 50)
                            : activityModel.cost.toString(),
                      ),
                    ),
                    // DataCell(
                    //   Text(
                    //     (activityModel.diesease_id.toString().length > 50)
                    //         ? activityModel.diesease_id.toString().substring(0, 50)
                    //         : activityModel.diesease_id.toString(),
                    //   ),
                    // ),
                    // DataCell(
                    //   Text(
                    //     (activityModel.bug_id.toString().length > 50)
                    //         ? activityModel.bug_id.toString().substring(0, 50)
                    //         : activityModel.bug_id.toString(),
                    //   ),
                    // ),
                    DataCell(
                      Text(
                        (activityModel.solve_by.toString().length > 50)
                            ? activityModel.solve_by.toString().substring(0, 50)
                            : activityModel.solve_by.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (value) => edit_activity ());
                        Navigator.pushNamed(context, "/edit_activity",
                            arguments: {'activity_id': activityModel.activity_id });
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(activityModel);
                      },
                    ))
                  ]),
                ).toList(),
              ),
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                'ยังไม่มีเครื่อง',
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
  }

  Future<Null> deletetime(ActivityModel farmModel) async {
    String? strtitle =
        'คุณต้องการลบรหัสฟาร์ม ' + farmModel.crop_id.toString() + ' นี้ใช่ไหม';
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: MyStyle().ShowTitle1(strtitle),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton.icon(
                        onPressed: () async {
                          String url =
                              'http://localhost/api_smartfarm-new/deleteactivity.php?isAdd=true&activity_id=${farmModel.activity_id}';
                          print(farmModel.activity_id);
                          await Dio().get(url);
                          getfarm();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.blueAccent,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        label: Text(
                          'ยืนยัน',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.blueAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                      label: Text(
                        'ยกเลิก',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

 String? farm_id , farm_name, email;

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id  = preferences.getString('farm_id');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

  bool readdata = false;
  getfarm() async {
    Showlist();
    activityModel.clear();
    print(activityModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
       farm_id = preferences.getString('farm_id');
    String? url = 'http://localhost/api_smartfarm-new/getactivity.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    //print('response==>$response');
    if (result.toString() != 'null') {
      //print(result.toString());
      for (var map in result) {
        ActivityModel activityModels = ActivityModel.fromJson(map);
        setState(() {
          activityModel.add(activityModels);
          readdata = true;
        });
      }
      //print(jsonEncode(FarmModels));
    } else {
      setState(() {
        activityModel = [];
        readdata = false;
      });
    }
  }
}
