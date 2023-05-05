import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:oyyo_maintence_app/Loging/login.dart';
import 'package:oyyo_maintence_app/Navpages/maintenanceList.dart';
import 'package:oyyo_maintence_app/Navpages/settingswidget.dart';

import 'package:oyyo_maintence_app/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final Authentication _auth = Authentication();

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    // print("=======================");
    // print(currentUserProfilePicture);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size15, horizontal: size20),
                    child: Text(
                      "PROFILE",
                      style: GoogleFonts.lexend(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize20,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size15, horizontal: size20),
                    child: Icon(Icons.account_circle_sharp,color: Colors.white,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size15,),
                    child: Text(
                      'Hi '  + currentUserName.toString() ,
                      style: GoogleFonts.lexend(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize15,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),


              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge(
                    //   toAnimate: false,
                    //   badgeColor: Colors.white,
                    //   badgeContent: SvgPicture.asset('assets/icons/profEdit.svg'),
                    //   position: BadgePosition.bottomEnd(bottom: 1, end: 20),
                    //   child:
                    // ),

                    SizedBox(
                      height: size20,
                    ),

                    SizedBox(
                      height: size8,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size40,
                  vertical: size35,
                ),
                child: Container(
                  height: scrWidth * 0.8,
                  child: Column(
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => SessionListScreen()));
                      //   },
                      //   child: SettingsTileWidget(
                      //     icon: 'assets/icons/upload.svg',
                      //     name: 'Upload Documents & Notes',
                      //   ),
                      // ),
                      SettingsTileWidget(
                        icon: 'assets/images/privacy.svg',
                        name: 'PRIVACY',
                      ),
                      SettingsTileWidget(
                        icon: 'assets/images/aboutUs.svg',
                        name: 'ABOUT US',
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(size20)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Are you sure you want to logout?",
                                      style: GoogleFonts.lexend(
                                          color: secondaryTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: fontSize14),
                                    ),
                                    SizedBox(
                                      height: size35,
                                    ),
                                    Row(
                                      children: [
                                        Bounce(
                                          duration: Duration(milliseconds: 110),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: scrWidth * 0.3,
                                            height: scrWidth * 0.1,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 2),
                                                    spreadRadius: 3,
                                                    blurRadius: 5,
                                                    color: Colors.grey
                                                        .withOpacity(0.2))
                                              ],
                                              color: Color(0xffD9D9D9),
                                              borderRadius:
                                              BorderRadius.circular(size20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSize14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size15,
                                        ),
                                        Bounce(
                                          duration: Duration(milliseconds: 110),
                                          onPressed: () async {
                                            // final SharedPreferences localStorage =
                                            // await SharedPreferences
                                            //     .getInstance();
                                            // localStorage.clear();


                                          },
                                          child: InkWell(
                                            child: Container(
                                              width: scrWidth * 0.3,
                                              height: scrWidth * 0.1,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 3,
                                                      blurRadius: 5,
                                                      color: Colors.grey
                                                          .withOpacity(0.2))
                                                ],
                                                color: mainColor.withOpacity(0.72),
                                                borderRadius:
                                                BorderRadius.circular(size20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Confirm',
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: fontSize14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              var prefs = await SharedPreferences.getInstance();
                                              prefs.clear();
                                              setState(() {

                                              });

                                             Navigator.push(context, MaterialPageRoute(builder: (context) {
                                               return login();
                                             },));
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: SettingsTileWidget(
                          icon: 'assets/icons/logout.svg',
                          name: 'LOGOUT',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ),
        );
  }
}