import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smartfarm/model/crop_model.dart';

import 'package:smartfarm/sceen/edit_crop.dart';
import 'package:smartfarm/style/Mystyle.dart';
import 'crop.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';


class Show_crop extends StatefulWidget {
  static const routeName = '/Show_crop';
  const Show_crop({Key? key}) : super(key: key);

  @override
  State<Show_crop> createState() => _Show_cropState();
}

class _Show_cropState extends State<Show_crop> {
  List<CropModel> cropModel = [];
  void initState() {
    getcrop();
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
                  'ข้อมูลการเพาะปลูก',
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
              "ข้อมูลรอบการปลูก",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 74, 216, 8),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Showlist()
        ]));
  }

  Widget create() => Container(
        width: 65,
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => crop());
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
    print('======>$readdata');
    return readdata
        ? Container(
            child: Container(
              margin: EdgeInsets.all(15),
              child: DataTable(
                columnSpacing: 10,
                horizontalMargin: 10,
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
                  DataColumn(
                    label: Text(
                      'รหัสรอบการปลูก',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'รหัสพืชพืช',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
               DataColumn(
                    label: Text(
                      'รหัสโรงเรียน',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),    
                  DataColumn(
                    label: Text(
                      'วันที่เริ่มปลูก',
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
                rows: cropModel.map(
                  (cropModel) => DataRow(cells: [
                    // DataCell(
                    //   Text(
                    //     (cropModel.farm_id.toString().length > 50)
                    //         ? cropModel.farm_id.toString().substring(0, 50)
                    //         : cropModel.farm_id.toString(),
                    //   ),
                    // ),
                    DataCell(
                      Text(
                        (cropModel.crop_id.toString().length > 50)
                            ? cropModel.crop_id.toString().substring(0, 50)
                            : cropModel.crop_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (cropModel.plant_id.toString().length > 50)
                            ? cropModel.plant_id.toString().substring(0, 50)
                            : cropModel.plant_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (cropModel.gh_id.toString().length > 50)
                            ? cropModel.gh_id.toString().substring(0, 50)
                            : cropModel.gh_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (cropModel.crop_date.toString().length > 50)
                            ? cropModel.crop_date.toString().substring(0, 50)
                            : cropModel.crop_date.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (value) => edit_crop());
                        Navigator.pushNamed(context, "/edit_crop",
                            arguments: {'crop_id': cropModel.crop_id});
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(cropModel);
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
                'ยังไม่เพาะปลูก',
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
  }

  Future<Null> deletetime(CropModel cropModel) async {
    String? strtitle = 'คุณต้องการลบข้อมูลการเพาะปลูก ' +
        cropModel.crop_id.toString() +
        ' นี้ใช่ไหม';
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
                              'http://localhost/api_smartfarm-new/deleteCrop.php?isAdd=true&crop_id=${cropModel.crop_id}';
                          print(cropModel.farm_id);
                          await Dio().get(url);
                          getcrop();
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
  getcrop() async {
    Showlist();
    cropModel.clear();
    print(cropModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
      farm_id = preferences.getString('farm_id');
    String? url = 'http://localhost/api_smartfarm-new/getCrop.php?isAdd=true&farm_id=${farm_id}';
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
}
