import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartfarm/style/dialog.dart';
import '../style/mystyle.dart';

////////////////////// DropdownButton///////////////////////
// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
// void main() => runApp(const DropdownButtonApp());

// class DropdownButtonApp extends StatelessWidget {
//   const DropdownButtonApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('DropdownButton Sample')),
//         body: const Center(
//           child: DropdownButtonExample(),
//         ),
//       ),
//     );
//   }
// }

// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample({super.key});

//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

////////////////////// DropdownButton///////////////////////
class plant extends StatefulWidget {
  const plant({Key? key}) : super(key: key);
  @override
  _plant createState() => _plant();
}

class _plant extends State<plant> {
  String? plant_id, plant_name, age, int, ph, temp_min, temp_max, farm_id;

  @override
  void initState() {
    var initState = super.initState();
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
          input_id(),
          input_name(),
          input_age(),
          input_ph(),
          input_temp_max(),
          input_temp_min(),
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
                    'farm_id=$farm_id,plant_id=$plant_id,plant_name=$plant_name,age=$age,ph=$ph,temp_max=$temp_max,temp_min=$temp_min,farm_id=$farm_id');
                if (plant_id == null || plant_id == '') {
                  normalDialog(context, '????????????????????????????????????????????????');
                  return;
                }
                if (plant_name == null || plant_name == '') {
                  normalDialog(context, '????????????????????????????????????????????????');
                  return;
                }
                if (age == null || age == '') {
                  normalDialog(context, '?????????????????????????????????????????????????????????????????????');
                  return;
                }
                if (ph == null || ph == '') {
                  normalDialog(context, '??????????????????????????? pH [ ]-[ ]');
                  return;
                }
                if (temp_max == null || temp_max == '') {
                  normalDialog(context, '??????????????????????????????????????????????????????????????????');
                  return;
                }
                if (farm_id == null || farm_id == '') {
                  normalDialog(context, '??????????????????????????????????????????????????????');
                  return;
                }
                if (temp_min == null || temp_min == '') {
                  normalDialog(context, '??????????????????????????????????????????????????????????????????');
                  return;
                }

                if (plant_id == null ||
                    plant_name == null ||
                    age == null ||
                    ph == null ||
                    temp_max == null ||
                    temp_min == null ||
                    plant_name == '' ||
                    plant_id == '' ||
                    age == '' ||
                    ph == '' ||
                    farm_id == '' ||
                    temp_max == '' ||
                    temp_min == '') {
                  normalDialog(context, '????????????????????????????????????????????????????????????????????????????????????');
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
                '???????????????????????????',
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
        'http://localhost/api_smartfarm-new/insert_plant.php?isAdd=true&farm_id=$farm_id&plant_id=$plant_id&plant_name=$plant_name&age=$age&ph=$ph&temp_max=$temp_max&temp_min=$temp_min';
    try {
      Response response = await Dio().get(url);
      print(response.toString() == "true");
      if (response.toString() == "false") {
        //regiterShow();
        normalDialog(context, '??????????????????????????????????????? $plant_id ');
      } else {
        Navigator.pop(context);
        normalDialog(context, '??????????????????????????????????????????????????????????????????');
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
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '??????????????????????????? :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_id() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => plant_id = value.trim(),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????????????????? :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_age() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => age = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????????????????? :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_name() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => plant_name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????????????????? :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );
  Widget input_ph() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => ph = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '????????? ph :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_temp_max() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => temp_max = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '?????????????????????????????????????????? :',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: MyStyle().textColorfocus)),
          ),
        ),
      );

  Widget input_temp_min() => Container(
        width: 250.0,
        margin: const EdgeInsets.all(10),
        child: TextField(
          onChanged: (value) => temp_min = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().textColor,
            ),
            labelStyle: TextStyle(color: MyStyle().textColor),
            labelText: '?????????????????????????????????????????? :',
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
