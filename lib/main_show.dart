import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:smartfarm/home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Home(),
    //Pondbecause(),
    // Pond(),
  
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      // bottomNavigationBar: BottomNavyBar(
      //   backgroundColor: Colors.green.shade50,
      //   selectedIndex: _currentIndex,
      //   showElevation: true,
      //   itemCornerRadius: 24,
      //   curve: Curves.easeIn,
      //   onItemSelected: (index) => setState(() => _currentIndex = index),
      //   items: <BottomNavyBarItem>[

      //     BottomNavyBarItem(
      //       icon: ImageIcon(
      //         AssetImage(""),
      //       ),
      //       title: Text('ตำแหน่ง ฟร์าม'),
      //       activeColor: Colors.green,
      //       textAlign: TextAlign.center,
      //     ),
      //     BottomNavyBarItem(
      //       icon: FaIcon(FontAwesomeIcons.fileAlt),
      //       title: Text(''),
      //       activeColor: Colors.green,
      //       textAlign: TextAlign.center,
      //     ),
      //   ],
      // ),
    );
  }
}
