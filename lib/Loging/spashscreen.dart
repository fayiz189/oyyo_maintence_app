import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oyyo_maintence_app/Loging/login.dart';
import 'package:oyyo_maintence_app/Navpages/history.dart';
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
      //  currentUserName= prefs.getString("name")!;
        currentUserHeadId=prefs.getString("headId")!;
        print("id $currentUserID");
         print("name $currentUserName");
        print("headId $currentUserHeadId");
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
      backgroundColor:mainColor,
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.35,
               width:MediaQuery.of(context).size.width*0.45 ,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(
                       'assets/images/oyyologo.png',
                   ),fit: BoxFit.contain
                 )
               ),

              ),
            ],
          ),
           CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
