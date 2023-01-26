import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/diesease_model.dart';
import 'package:smartfarm/sceen/diesease.dart';
import 'package:smartfarm/sceen/edit_diesease.dart';


import '../style/Mystyle.dart';

class Show_diesease extends StatefulWidget {
     static const routeName = '/Show_diesease';
  const Show_diesease({Key? key}) : super(key: key);
  @override
  _Show_diesease createState() => _Show_diesease();
}

class _Show_diesease extends State<Show_diesease> {
  TextEditingController greenhousenumber = TextEditingController();
  List<DieseaseModel> dieseaseModel = [];
  int index = 0;
  @override
  void initState() {
    getgreenhouse();
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'ข้อมูลโรคพืช',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          Row(
            children: [create()],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          // MyStyle().ShowLogo3(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: const Text(
              "ข้อมูลโรคพืช",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 74, 216, 8),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Showlist()
        ],
      ),
    );
  }

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
                  //   label: Text(
                  //     'รหัสฟร์าม',
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  DataColumn(
                    label: Text(
                      'รหัสโรคพืช',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'รหัสชื่อโรคพืช',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'แก้ไขข้อมูล',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ลบข้อมูล',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: dieseaseModel.map(
                  (dieseaseModel) => DataRow(cells: [
                    //  DataCell(
                    //   Text(
                    //     (dieseaseModel.farm_id.toString().length > 50)
                    //         ? dieseaseModel.farm_id.toString().substring(0, 50)
                    //         : dieseaseModel.farm_id.toString(),
                    //   ),
                    // ),
                    DataCell(
                      Text(
                        (dieseaseModel.diesease_id.toString().length > 50)
                            ? dieseaseModel.diesease_id.toString().substring(0, 50)
                            : dieseaseModel.diesease_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (dieseaseModel.diesease_name.toString().length > 50)
                            ? dieseaseModel.diesease_name.toString().substring(0, 50)
                            : dieseaseModel.diesease_name.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (value) => edit_diesease());
                        Navigator.pushNamed(context, "/edit_diesease",
                            arguments: {'diesease_id': dieseaseModel.diesease_id});
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(dieseaseModel);
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
                'ยังไม่มีโรงเรือน',
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
  }

  Future<Null> deletetime(DieseaseModel greehouseModel) async {
    String? strtitle = 'คุณต้องการลบโรงเรือน ' +
        greehouseModel.diesease_id.toString() +
        ' นี้ใช่ไหม';
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              // title: const Text('ยืนยันการลบข้อมูลหรือไม่'),
              title: MyStyle().ShowTitle1(strtitle),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton.icon(
                        onPressed: () async {
                          String url =
                              'http://chiangraismartfarm.com/APIsmartfarm/deletediesease.php?isAdd=true&farm_id=${greehouseModel.farm_id}';
                          print(greehouseModel.diesease_id);
                          await Dio().get(url);
                          getgreenhouse();
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
  getgreenhouse() async {
    dieseaseModel.clear();
    print(dieseaseModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url = 'http://chiangraismartfarm.com/APIsmartfarm/getdiesease.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('response==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        DieseaseModel greehouseModel = DieseaseModel.fromJson(map);
        setState(() {
          dieseaseModel.add(greehouseModel);
          readdata = true;
        });
      }
      print(jsonEncode(dieseaseModel));
    } else {
      setState(() {
        dieseaseModel = [];
        readdata = false;
      });
    }
  }

  Widget create() => Container(
        width: 65,
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => diesease());
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
}

class ShowTitle1 {}
