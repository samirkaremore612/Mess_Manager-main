import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sub_mgmt/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sub_mgmt/page/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();

}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:1),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    LoginPage()
                // myApp()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashphoto1.jpg'),
            Text('MESS MANAGEMENT',style: TextStyle(fontWeight: FontWeight.bold,fontSize:30)),
            SizedBox(height: 10,),
            SpinKitFoldingCube(
              color: Colors.deepOrange,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}