import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oyyo_maintence_app/Loging/login.dart';
import 'package:oyyo_maintence_app/bottomNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 4), () async {
      var prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("uid")) {
        currentUserID=prefs.getString("uid")!;
        print("id $currentUserID");
        // print(prefs.get('email'));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      }
      else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contex)=>login()), (route) => false);

      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:CircularProgressIndicator(
        ),
      ),
    );
  }
}
