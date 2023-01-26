import 'package:flutter/material.dart';
import 'package:smartfarm/sceen/Show_activity.dart';
import 'package:smartfarm/sceen/Show_bug.dart';
import 'package:smartfarm/sceen/Show_crop.dart';
import 'package:smartfarm/sceen/Show_crop_close.dart';
import 'package:smartfarm/sceen/Show_diesease.dart';
import 'package:smartfarm/sceen/Show_farm.dart';
import 'package:smartfarm/sceen/Show_greenhouse.dart';
import 'package:smartfarm/sceen/Show_plant.dart';
import 'package:smartfarm/sidemenu.dart';
import 'package:smartfarm/style/mystyle.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Container(
          // width: 1000,
          // height: 500,
          // color: Color.fromARGB(255, 10, 239, 33),
          child: GridView.extent(
            // primary: false,
            // crossAxisCount: 3,
            padding: EdgeInsets.all(16),
            mainAxisSpacing: 2,
            crossAxisSpacing: 3,
            maxCrossAxisExtent: 200,
            // width: 250,
            // height: 250,
            // maxCrossAxisExtent: 200,

            children: <Widget>[
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_plant());
                  Navigator.push(context, route);
                },
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: 50, maxWidth: 50, minWidth: 0, minHeight: 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/10.png',
                      ),
                      Text('ข้อมูลพืช'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_greenhouse());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/1.png',
                      ),
                      Text('ข้อมูลโรงเรียน'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_crop());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/11.png',
                      ),
                      Text('ข้อมูลรอบการปลูก'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_crop_close());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/12.png',
                      ),
                      Text('ข้อมูลเก็บเกี่ยวผลผลิต'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_diesease());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/1.png',
                      ),
                      Text('ข้อมูลโรคพืช'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_bug());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/13.jpg',
                      ),
                      Text('ข้อมูลศัตรูพืช'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => Show_activity());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/14.png',
                      ),
                      Text('ข้อมูลการดูแลพืช'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SideMenu(),
    );
  }
}
