import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/plant_model.dart';
import 'package:smartfarm/sceen/edit_plant.dart';
import 'package:smartfarm/sceen/plant.dart';
import 'package:smartfarm/style/mystyle.dart';


class Show_plant extends StatefulWidget {

  const Show_plant({Key? key}) : super(key: key);
  @override
  _Show_plantState createState() => _Show_plantState();
}

class _Show_plantState extends State<Show_plant> {
  TextEditingController greenhousenumber = TextEditingController();
  List<PlantModel> PlantModels = [];
  int index = 0;
  @override
  void initState() {
    getplant();
    getName();
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
                'ข้อมูลพืช',
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
              "ข้อมูลพืช",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 10, 10, 11),
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
                  //  DataColumn(
                  //   label: Text(
                  //     'รหัสฟร์าม',
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  DataColumn(
                    label: Text(
                      'รหัสพืช',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ชื่อพืช',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'อายุพืช(วัน)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ค่า PH ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'อุณหภูมิสูงสุด(%)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'อุณหภูมิต่ำสุด(%)',
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
                rows: PlantModels.map(
                  (PlantModels) => DataRow(cells: [
                    // DataCell(
                    //   Text(
                    //     (PlantModels.farm_id.toString().length > 50)
                    //         ? PlantModels.farm_id.toString().substring(0, 50)
                    //         : PlantModels.farm_id.toString(),
                    //   ),
                    // ),
                    DataCell(
                      Text(
                        (PlantModels.plant_id.toString().length > 50)
                            ? PlantModels.plant_id.toString().substring(0, 50)
                            : PlantModels.plant_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (PlantModels.plant_name.toString().length > 50)
                            ? PlantModels.plant_name.toString().substring(0, 50)
                            : PlantModels.plant_name.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (PlantModels.age.toString().length > 50)
                            ? PlantModels.age.toString().substring(0, 50)
                            : PlantModels.age.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (PlantModels.ph.toString().length > 50)
                            ? PlantModels.ph.toString().substring(0, 50)
                            : PlantModels.ph.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (PlantModels.temp_max.toString().length > 50)
                            ? PlantModels.temp_max.toString().substring(0, 50)
                            : PlantModels.temp_max.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (PlantModels.temp_min.toString().length > 50)
                            ? PlantModels.temp_min.toString().substring(0, 50)
                            : PlantModels.temp_min.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (value) => edit_plant());
                        Navigator.pushNamed(context, "/edit_plant",
                            arguments: {'plant_id': PlantModels.plant_id});
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(PlantModels);
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
                'ยังไม่พืช',
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

  Future<Null> deletetime(PlantModel plantModel) async {
    String? strtitle =
        'คุณต้องการลบรหัสพืช ' + plantModel.farm_id.toString() + ' นี้ใช่ไหม';
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
                              'http://chiangraismartfarm.com/APIsmartfarm/deletePlant.php?isAdd=true&farm_id=${plantModel.farm_id}';
                          print(plantModel.farm_id);
                          await Dio().get(url);
                          getplant();
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
  getplant() async {
    PlantModels.clear();
    print(PlantModels);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getPlant.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('response==>$response');
    if (result.toString() != 'null') {
      print(result.toString());
      for (var map in result) {
        PlantModel plantModel = PlantModel.fromJson(map);
        setState(() {
          PlantModels.add(plantModel);
          readdata = true;
        });
      }
      print(jsonEncode(PlantModels));
    } else {
      setState(() {
        PlantModels = [];
        readdata = false;
      });
    }
  }

  Widget create() => Container(
        width: 65,
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => plant());
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
