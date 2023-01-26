import 'package:flutter/material.dart';

import 'package:smartfarm/style/mystyle.dart';

class WarnApp extends StatefulWidget {
  const WarnApp({Key? key}) : super(key: key);

  @override
  _WarnAppState createState() => _WarnAppState();
}

class _WarnAppState extends State<WarnApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff159e59),
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            MyStyle().showcrru(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'แจ้งเตือน',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
