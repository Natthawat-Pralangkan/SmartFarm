import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/home.dart';
import 'package:smartfarm/profile.dart';
import 'package:smartfarm/settings.dart';
import 'package:smartfarm/sceen/signin.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);
  @override
  _SideMenu createState() => _SideMenu();
  static const routeName = 'Profile';
}

class _SideMenu extends State<SideMenu> {
  void initState() {
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('$farm_name'),
            accountEmail: Text('$email'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://www3.singarea.org/~asis-ed/images/welcome.jpg"),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, Profile.routeName);
            },
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.lock_open),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pushNamed(context, Signin.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? farm_id, farm_name, email;
  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      farm_id = preferences.getString('farm_id ');
      farm_name = preferences.getString('farm_name');
      email = preferences.getString('email');
    });
  }
}
