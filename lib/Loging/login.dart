import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oyyo_maintence_app/Navpages/maintenanceList.dart';
import 'package:oyyo_maintence_app/bottomNavbar.dart';
import 'package:oyyo_maintence_app/const.dart';
import 'package:oyyo_maintence_app/regExp.dart';
import 'package:shared_preferences/shared_preferences.dart';

String currentUserID='';
String currentUserName='';
String currentUserEmail='';
String currentUserHeadId = '';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool passanable = true;
  final username = TextEditingController();
  final password = TextEditingController();

  getUser() async {
    QuerySnapshot users=await FirebaseFirestore.instance
        .collection('maintenanceStaff')
        .where("delete",isEqualTo: false)
        .where("userName",isEqualTo: username.text)
        .where("password",isEqualTo: password.text)
        .get();
    if(users.docs.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user not exist")));
print("test");
    }else{
      var prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', users.docs[0].id);
        prefs.setString('headId', users.docs[0]['headId']);
         // prefs.setString('name', users.docs[0]['name']);
         // print( prefs.getString('name'));
         print(" prefs.getString('name')");


      DocumentSnapshot data=users.docs[0];
      currentUserEmail=data.get('email');
      currentUserID=data.id;
      currentUserName=data.get('name');
      currentUserHeadId = data.get('headId');
      print(currentUserID);
      print(currentUserEmail);
      print(currentUserName);

      
      setState(() {

      });

      Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage(),));

    }



  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    // height: w * 2.2,
                    padding: EdgeInsets.only(
                        left: w * 0.05, top: w * 0.05, right: w * 0.05),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: w*0.2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/oyyologo.png",
                                height: w * 0.3,
                                width: w * 0.4,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: w * 0.08,
                          ),
                          Text("Login to your Account",
                            style:GoogleFonts.inter(
                              fontSize: w*0.05,
                              fontWeight: FontWeight.w700,
                                color:Colors.black
                            ),),
                          SizedBox(height: w*0.05,),

                          Text(
                            "Username",
                            style: GoogleFonts.inter(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: w*0.05),
                          ),
                          SizedBox(
                            height: w*0.02,
                          ),
                          Center(
                            child: Container(
                              width: w * 0.85,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              height: w*0.15,
                              child: TextFormField(
                                // autovalidateMode:
                                //     AutovalidateMode.onUserInteraction,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return '';
                                //   } else if (!emailRegExp.hasMatch(value)) {
                                //     return 'enter valid Username';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                obscureText: false,
                                controller: username,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  hintStyle: TextStyle(fontSize: 21),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w*0.04),
                          Text(
                            "Password",
                            style: GoogleFonts.inter(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: w* 0.85,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18)),
                               height: w*0.15,
                              child: TextFormField(
                                // autovalidateMode:
                                //     AutovalidateMode.onUserInteraction,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'please enter password';
                                //   } else if (!passwordRegExp.hasMatch(value)) {
                                //     return 'enter valid password';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller: password,
                                obscureText: passanable,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                  ),
                                  hintStyle: TextStyle(fontSize: 21),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w*0.05,),

                          Center(
                            child: InkWell(
                              child: Container(
                                width: w*0.85,
                                // height: 72,
                                height: w*0.15,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.06),
                                        offset: const Offset(0, 4),
                                        blurRadius: 15,
                                        spreadRadius: 5),
                                  ],
                                  color: Color(0xff3896CC),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child:  Center(
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: w*0.05),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if(username.text!=''&&password.text!=''){
                                  getUser();
                                }

                              },
                            ),

                          ),
                    SizedBox(height: w*0.08,),

                    // Container(
                    //     width: w*0.2,
                    //     // height: 72,
                    //     height: w * 0.18,
                    //     decoration: BoxDecoration(
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.black.withOpacity(.06),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 15,
                    //             spreadRadius: 5),
                    //       ],
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //  child:  Center(
                    //     child: Image.asset(
                    //         "assets/images/Google free icons designed by Driss Lebbat.png",
                    //         width: w * 0.12,
                    //         height: w * 0.12),
                    //   ),
                    //
                    // ),
                          Center(child: Text("V.1.0.0",style: TextStyle(color: Colors.grey),))


                        ]
                    )
                )

            )
        )
    );
  }
}
