import 'package:flutter/material.dart';
  
class Settings extends StatefulWidget {
    static const routeName = '/settings';
 
    const Settings({Key? key}) : super(key: key);
  
    @override
    State<StatefulWidget> createState() {
        return _SettingsState();
    }
}
  
class _SettingsState extends State<Settings> {
  
    @override
    Widget build(BuildContext context) {
  
        return Scaffold(
            appBar: AppBar(
                title: Text('Settings'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('Settings Screen'),
                    ],
                )
            ),
        );
    }
}