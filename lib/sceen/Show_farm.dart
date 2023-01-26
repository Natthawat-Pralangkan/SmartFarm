import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/model/farm_model.dart';
import 'package:smartfarm/sceen/edit_farm.dart';
import '../style/Mystyle.dart';
import 'farm.dart';



class Show_farm extends StatefulWidget {
      static const routeName = '/Show_farm';
  const Show_farm({Key? key}) : super(key: key);

  @override
  State<Show_farm> createState() => _Show_farmState();
}

class _Show_farmState extends State<Show_farm> {
  TextEditingController farm = TextEditingController();
  TextEditingController farm1 = TextEditingController();
  TextEditingController farm2 = TextEditingController();
  List<FarmModel> farmModel = [];
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
                'ข้อมูลฟาร์ม',
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
            "ข้อมูลฟาร์ม",
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
                MaterialPageRoute(builder: (value) => Infarm());
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
                  DataColumn(
                    //width: 65,
                    label: Text(
                      'รหัสฟาร์ม',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ชื่อฟาร์ม',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ที่อยู่',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ตำบล',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'อำเภอ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'จังหวัด',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'อีเมล์',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ประเภทผู้ใช้',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ตำบล',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ละติจูด',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ลองติจูด',
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
                rows: farmModel.map(
                  (farmModel) => DataRow(cells: [
                    DataCell(
                      Text(
                        (farmModel.farm_id.toString().length > 50)
                            ? farmModel.farm_id.toString().substring(0, 50)
                            : farmModel.farm_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.farm_name.toString().length > 50)
                            ? farmModel.farm_name.toString().substring(0, 50)
                            : farmModel.farm_name.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.address.toString().length > 50)
                            ? farmModel.address.toString().substring(0, 50)
                            : farmModel.address.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.tumbon.toString().length > 50)
                            ? farmModel.tumbon.toString().substring(0, 50)
                            : farmModel.tumbon.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.amphur.toString().length > 50)
                            ? farmModel.amphur.toString().substring(0, 50)
                            : farmModel.amphur.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.province.toString().length > 50)
                            ? farmModel.province.toString().substring(0, 50)
                            : farmModel.province.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.email.toString().length > 50)
                            ? farmModel.email.toString().substring(0, 50)
                            : farmModel.email.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.password.toString().length > 50)
                            ? farmModel.password.toString().substring(0, 50)
                            : farmModel.password.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.typeuser.toString().length > 50)
                            ? farmModel.typeuser.toString().substring(0, 50)
                            : farmModel.typeuser.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.lat.toString().length > 50)
                            ? farmModel.lat.toString().substring(0, 50)
                            : farmModel.lat.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (farmModel.Lng.toString().length > 50)
                            ? farmModel.Lng.toString().substring(0, 50)
                            : farmModel.Lng.toString(),
                      ),
                    ),

                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (value) => edit_farm());
                        Navigator.pushNamed(context, "/edit_farm",
                            arguments: {'farm_id': farmModel.farm_id});
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(farmModel);
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

  Future<Null> deletetime(FarmModel farmModel) async {
    String? strtitle =
        'คุณต้องการลบฟาร์ม ' + farmModel.farm_id.toString() + ' นี้ใช่ไหม';
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
                              'http://localhost/api1/deleteFarm.php?isAdd=true&farm_id=${farmModel.farm_id}';
                          print(farmModel.farm_id);
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

  String? farm_IDa = '';
  gettextfarm(String? IDfarm, {String? Namefarm, Latfarm, Lngfarm}) async {
    print(IDfarm);
    setState(() {
      farm_IDa = IDfarm ?? '';
      farm.text = Namefarm ?? '';
      farm1.text = Latfarm ?? '';
      farm2.text = Lngfarm ?? '';
    });
  }

  bool readdata = false;
  getfarm() async {
    Showlist();
    farmModel.clear();
    print(farmModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? url = 'http://localhost/api1/getFarm.php?isAdd=true';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    //print('response==>$response');
    if (result.toString() != 'null') {
      //print(result.toString());
      for (var map in result) {
        FarmModel farmModels = FarmModel.fromJson(map);
        setState(() {
          farmModel.add(farmModels);
          readdata = true;
        });
      }
      //print(jsonEncode(FarmModels));
    } else {
      setState(() {
        farmModel = [];
        readdata = false;
      });
    }
  }
}
