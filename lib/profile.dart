import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/style/Mystyle.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
  static const routeName = 'Profile';
}

class _ProfileState extends State<Profile> {
  void initState() {
    getName();
    super.initState();
  }

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
            // MyStyle().showcrru(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 69),
              child: Text(
                'บัญชี',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            )
          ],
        ),
      ),
      body: _profilePage(context),
    );
  }

  Widget _profilePage(context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            _avatar(),
            _changeAvatarButton(),
            _usernameTile(),
            _emailTile(),
            // _descriptionTile(context),
          ],
        ),
      ),
    );
  }

  String? farm_id , farm_name, email;
  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id  = preferences.getString('farm_id ');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }

  Widget _avatar() {
    return CircleAvatar(
      radius: 50,
      child: Icon(Icons.person),
    );
  }

  Widget _changeAvatarButton() {
    return TextButton(
      onPressed: () {},
      child: Text('เปลี่ยน รูป'),
    );
  }

  Widget _usernameTile() {
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(Icons.person),
      title: Text('$farm_name'),
    );
  }

  Widget _emailTile() {
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(Icons.mail),
      title: Text('$email'),
    );
  }

  // Widget _descriptionTile(context) {
  //   return ListTile(
  //     tileColor: Colors.white,
  //     leading: Icon(Icons.edit),
  //     title: TextButton(
  //         onPressed: () {
  //           // MaterialPageRoute route =
  //           //     MaterialPageRoute(builder: (value) => EditPasswore());
  //           // Navigator.push(context, route);
  //         },
  //         child: Align(
  //           alignment: Alignment.topLeft,
  //           child: Text(
  //             "เปลี่ยนรหัสผ่าน",
  //             style: TextStyle(fontSize: 16.0, color: Colors.black),
  //           ),
  //         )),
  //   );
  // }
}
