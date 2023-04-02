import 'package:flutter/material.dart';
import 'package:sub_mgmt/widget/navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        body: Center(
          child: Text('This is Settings Page', style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}