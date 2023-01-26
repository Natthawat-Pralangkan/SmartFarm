import 'package:flutter/material.dart';
import 'package:smartfarm/home.dart';
import 'package:smartfarm/profile.dart';
import 'package:smartfarm/sceen/Show_activity.dart';
import 'package:smartfarm/sceen/Show_bug.dart';
import 'package:smartfarm/sceen/Show_crop.dart';
import 'package:smartfarm/sceen/Show_crop_close.dart';
import 'package:smartfarm/sceen/Show_farm.dart';
import 'package:smartfarm/sceen/Show_greenhouse.dart';
import 'package:smartfarm/sceen/Show_plant.dart';
import 'package:smartfarm/sceen/edit_activity.dart';
import 'package:smartfarm/sceen/edit_bug.dart';
import 'package:smartfarm/sceen/edit_crop.dart';
import 'package:smartfarm/sceen/edit_crop_close.dart';
import 'package:smartfarm/sceen/edit_diesease.dart';
import 'package:smartfarm/sceen/edit_greenhouse.dart';
import 'package:smartfarm/sceen/edit_plant.dart';
import 'package:smartfarm/sceen/routes.dart';
import 'package:smartfarm/sceen/signin.dart';
import 'package:smartfarm/settings.dart';
import 'sceen/Show_diesease.dart';

void main() {
  runApp(const MyApp());
}

// ส่วนของ Stateless widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/Signin', // สามารถใช้ home แทนได้
      routes: {
        Signin.routeName: (context) => Signin(),
        Home.routeName: (context) => Home(),
        Profile.routeName: (context) => Profile(),
        Settings.routeName: (context) => Settings(),
        MyRoutes.Show_plant: (context) => Show_plant(),
        MyRoutes.Show_greenhouse: (context) => Show_greenhouse(),
        MyRoutes.Show_farm: (context) => Show_farm(),
        MyRoutes.Show_diesease: (context) => Show_diesease(),
        MyRoutes.Show_crop: (context) => Show_crop(),
        MyRoutes.Show_crop_close: (context) => Show_crop_close(),
        MyRoutes.Show_bug: (context) => Show_bug(),
        MyRoutes.Show_activity: (context) => Show_activity(),
        MyRoutes.edit_plant: (context) => edit_plant(),
        MyRoutes.edit_greenhouse: (context) => edit_greenhouse(),
        MyRoutes.edit_crop: (context) => edit_crop(),
        MyRoutes.edit_crop_close: (context) => edit_crop_close(),
        MyRoutes.edit_bug: (context) => edit_bug(),
        MyRoutes.edit_activity: (context) => edit_activity(),
        MyRoutes.edit_diesease: (context) => edit_diesease(),
      },
    );
  }
}
