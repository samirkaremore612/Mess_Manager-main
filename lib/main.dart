import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sub_mgmt/globals.dart';
import 'package:sub_mgmt/page/expensetracker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sub_mgmt/page/notifs_page.dart';
import 'package:sub_mgmt/page/settingspage.dart';
import 'package:sub_mgmt/page/sortablepage.dart';
import 'package:sub_mgmt/page/splash.dart';
import 'package:sub_mgmt/widget/navigation_drawer.dart';
import 'package:sub_mgmt/page/notifs_page.dart';

// This is main.dart file
// ignore_for_file: prefer_const_constructors

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox("expense_database");
  ReturnNotification();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home:SplashScreen(),
  )
  );
}


class myApp extends StatefulWidget {
  myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => MainPage();
}

class MainPage extends State<myApp> {
  int currentIndex = 0;
  final screens = [
    MemberList(),
    NotifsPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('images/profile_bgcrop.png'), context);
    precacheImage(AssetImage('images/dummyfood.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      home: Scaffold(
        body: screens[currentIndex],
        backgroundColor: Colors.white,
        drawer: NavigationDrawerWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: myAppBar
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0x54000000),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: bottomNavigationBar,
        ),
      ),
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
      ),
      child: BottomNavigationBar(
        // elevation: 1.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        unselectedItemColor: Color.fromARGB(80, 0, 0, 0),
        selectedFontSize: 12,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget get myAppBar {
    final appbarTitle = ["Members", "Notifications", "Settings"];
    return AppBar(
      centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 8,
        toolbarHeight: 70,
        title: Text(
          appbarTitle[currentIndex],
          style: TextStyle(
            fontFamily: GoogleFonts.rubik().fontFamily
            // fontWeight: FontWeight.bold
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: const [Colors.blueAccent, Colors.blue],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)
          ),
        )
    );
  }
}
