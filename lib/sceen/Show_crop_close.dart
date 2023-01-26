import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/model/crop_close_model.dart';
import 'package:smartfarm/sceen/crop_close.dart';
import 'package:smartfarm/sceen/edit_crop_close.dart';
import '../style/Mystyle.dart';

class Show_crop_close extends StatefulWidget {
  static const routeName = '/Show_crop_close';
  const Show_crop_close({Key? key}) : super(key: key);

  @override
  State<Show_crop_close> createState() => _Show_crop_close();
}

class _Show_crop_close extends State<Show_crop_close> {
  TextEditingController crop = TextEditingController();
  List<CloseCropModel> close_CropModel = [];
  int index = 0;
  void initState() {
    getCloseCrop();
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
                'ข้อมูลการเก็บเกี่ยว',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          Row(
            children: [
              Column(
                children: [
                  create(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: const Text(" "),
                  ),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          // MyStyle().ShowLogo3(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: const Text(" "),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: const Text(
              "ข้อมูลการเก็บเกี่ยว",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 74, 216, 8),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Showlist(),
        ],
      ),
    );
  }

  Widget create() => Container(
        width: 65,
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => crop_close());
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
                      'วันที่เก็บเกี่ยว',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'รายได้(บาท)',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ต้นทุน(บาท)',
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
                rows: close_CropModel.map(
                  (close_CropModel) => DataRow(cells: [
                    // DataCell(
                    //   Text(
                    //     (close_CropModel.farm_id.toString().length > 50)
                    //         ? close_CropModel.farm_id.toString().substring(0, 50)
                    //         : close_CropModel.farm_id.toString(),
                    //   ),
                    // ),
                    DataCell(
                      Text(
                        (close_CropModel.crop_id.toString().length > 50)
                            ? close_CropModel.crop_id.toString().substring(0, 50)
                            : close_CropModel.crop_id.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (close_CropModel.close_date.toString().length > 50)
                            ? close_CropModel.close_date.toString().substring(0, 50)
                            : close_CropModel.close_date.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (close_CropModel.amount.toString().length > 50)
                            ? close_CropModel.amount.toString().substring(0, 50)
                            : close_CropModel.amount.toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        (close_CropModel.cost.toString().length > 50)
                            ? close_CropModel.cost.toString().substring(0, 50)
                            : close_CropModel.cost.toString(),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (value) => edit_crop_close());
                        Navigator.pushNamed(context, "/edit_crop_close",
                            arguments: {'crop_id': close_CropModel.crop_id});
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deletetime(close_CropModel);
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

  Future<Null> deletetime(CloseCropModel closeCropModel) async {
    String? strtitle = 'คุณต้องการลบเก็บเกี่ยว ' +
        closeCropModel.crop_id.toString() +
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
                              'http://chiangraismartfarm.com/APIsmartfarm/deleteCloseCrop.php?isAdd=true&crop_id=${closeCropModel.crop_id}';
                          print(closeCropModel.crop_id);
                          await Dio().get(url);
                          getCloseCrop();
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

  String? farm_id, farm_name, email;

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
    Showlist();
    close_CropModel.clear();
    print(close_CropModel);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    farm_id = preferences.getString('farm_id');
    String? url =
        'http://chiangraismartfarm.com/APIsmartfarm/getCloseCrop.php?isAdd=true&farm_id=${farm_id}';
    Response response = await Dio().get(url);
    print('===>$response');
    var result = json.decode(response.data);
    print(result.toString());
    if (result.toString() != 'null') {
      //print(result.toString());
      for (var map in result) {
        CloseCropModel close_CropModels = CloseCropModel.fromJson(map);
        setState(() {
          close_CropModel.add(close_CropModels);
          readdata = true;
        });
      }
      //print(jsonEncode(CropModels));
    } else {
      setState(() {
        close_CropModel = [];
        readdata = false;
      });
    }
  }
}
