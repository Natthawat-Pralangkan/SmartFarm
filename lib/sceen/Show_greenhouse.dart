import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/greenhouse_model.dart';
import 'package:smartfarm/sceen/edit_greenhouse.dart';
import '../style/Mystyle.dart';
import 'greenhouse.dart';


class Show_greenhouse extends StatefulWidget {
    // static const routeName = '/Show_greenhouse';
  const Show_greenhouse({Key? key}) : super(key: key);
  @override
  _Show_greenhouseState createState() => _Show_greenhouseState();
}

class _Show_greenhouseState extends State<Show_greenhouse> {
  TextEditingController greenhousenumber = TextEditingController();
  List<GreehouseModel> greehouseModel = [];
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
                'ข้อมูลโรงเรือน',
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
              "ข้อมูลโรงเรือน",
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
                      'รหัสโรงเรือน',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ชื่อโรงเรือน',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                   DataColumn(
                    label: Text(
                      'สถานะ',
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
                rows: greehouseModel.map(
                  (greehouseModel) => DataRow(cells: [
                    // DataCell(
                    //   Text(
                    //     (greehouseModel.farm_id.toString().length > 50)
                    //         ? greehouseModel.farm_id.toString().substring(0, 50)
                    //         : greehouseModel.farm_id.toString(),
                    //   ),
                    // ),
                    DataCell(
                      Text(
                        (greehouseModel.gh_id.toString().length > 50)
                            ? greehouseModel.gh_id.toString().substring(0, 50)
                            : greehouseModel.gh_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (greehouseModel.gh_name.toString().length > 50)
                            ? greehouseModel.gh_name.toString().substring(0, 50)
                            : greehouseModel.gh_name.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (greehouseModel.gh_status.toString().length > 3)
                            ? greehouseModel.gh_status.toString().substring(0, 3)
                            : greehouseModel.gh_status.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (value) => edit_greenhouse());
                        Navigator.pushNamed(context, "/edit_greenhouse",
                            arguments: {'gh_id': greehouseModel.gh_id});
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(greehouseModel);
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
  String? farm_id , farm_name, email;
   getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id  = preferences.getString('farm_id');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

  Future<Null> deletetime(GreehouseModel greehouseModel) async {
    String? strtitle = 'คุณต้องการลบโรงเรือน ' +
        greehouseModel.farm_id.toString() +
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
                              'http://chiangraismartfarm.com/APIsmartfarm/deleteGreenHouse.php?isAdd=true&gh_id=${greehouseModel.gh_id}';
                          print(greehouseModel.gh_id);
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

  bool readdata = false;
  getgreenhouse() async {
    greehouseModel.clear();
    print(greehouseModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
      farm_id = preferences.getString('farm_id');
    String? url = 'http://chiangraismartfarm.com/APIsmartfarm/getGreenhouse.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('response==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        GreehouseModel greehouseModels = GreehouseModel.fromJson(map);
        setState(() {
          greehouseModel.add(greehouseModels);
          readdata = true;
        });
      }
      print(jsonEncode(greehouseModel));
    } else {
      setState(() {
        greehouseModel = [];
        readdata = false;
      });
    }
  }

  Widget create() => Container(
        width: 65,
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => greenhouse());
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
