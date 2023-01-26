import 'package:flutter/material.dart';
import 'package:smartfarm/sceen/warn_page.dart';

class MyStyle {
  Color textColor = Color.fromARGB(255, 11, 11, 11);
  Color textColorfocus = Colors.blueAccent.shade700;
  SizedBox sizedbox() => SizedBox(
        height: 10.0,
        width: 10.0,
      );
  SizedBox sizedbox1() => SizedBox(
        height: 200.0,
      );
  SizedBox sizedbox3() => SizedBox(
        height: 30.0,
        width: 20.0,
      );
  SizedBox sizedbox4() => SizedBox(
        height: 200.0,
      );
  SizedBox sizedbox5() => SizedBox(
        height: 10.0,
      );
  SizedBox sizedbox6() => SizedBox(
        height: 230.0,
      );

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Text ShowTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.green.shade700,
            fontWeight: FontWeight.bold),
      );

  Text ShowTitle1(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.green.shade700,
            fontWeight: FontWeight.bold),
      );

  Image ShowLogo() {
    return Image.asset(
      'image/1.png',
      height: 250,
      width: 250,
    );
  }

  Image ShowLogopassword() {
    return Image.asset(
      '../image/password.png',
      height: 110.0,
    );
  }

  Container showcrru() {
    return Container(
// decoration: new BoxDecoration(color: Colors.black),
      height: 250,
      width: 250,
      child: Image.asset('../image/logo.webp'),
    );
  }

  MyStyle();
}

TextButton alertButton(context) {
  return TextButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(4),
      ),
    ),
    child: Column(
      children: <Widget>[
        Icon(
          Icons.add_alert,
          color: Colors.yellowAccent.shade700,
          size: 25,
        ),
        const Text(
          "แจ้งเตือน/Warning",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    ),
    onPressed: () {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => WarnApp());
      Navigator.push(context, route);
    },
  );
}
