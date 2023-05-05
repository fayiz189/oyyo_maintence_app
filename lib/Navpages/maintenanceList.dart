import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oyyo_maintence_app/Loging/login.dart';
import 'package:oyyo_maintence_app/Navpages/complaint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var w;
var mainColor= Color(0xFF084586);

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {



  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Container(
          width: double.infinity,
          // height: w * 2.2,
          padding:
              EdgeInsets.only(left: w * 0.05, top: w * 0.05, right: w * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   "assets/images/oyyologo.png",
              //   height: w * 0.16,
              //   width: w * 0.2,
              //   fit: BoxFit.contain,
              // ),
              SizedBox(
                height: w * 0.04,
              ),
              Text(
                "MAINTENANCE",
                style: GoogleFonts.inter(
                  color: Colors.white,
                    fontWeight: FontWeight.w700, fontSize: w * 0.05),
              ),
              SizedBox(
                height: w * 0.06,
              ),
              Container(
                height: w*1.58,

                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("complaints")
                    .where("staff",isEqualTo: currentUserID)
                    .where("status",whereIn: [2,3,6],)

                        .snapshots(),
                    builder: (context, snapshot) {
                      print(currentUserID);
                      if(!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(

                          ),
                        );                    }
                      var data=snapshot.data!.docs;
                      return data.isEmpty? Padding(
                        padding: const EdgeInsets.only(top: 250),
                        child: Center(child: Text('No Complaints Found',style: TextStyle(color: Colors.white,
                        fontSize: 14),)),
                      ):

                        ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount:data.length,itemBuilder:(context, index) {
                        return // Generated code for this Container Widget...
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(w*0.02, w*0.02, w*0.02, 0),
                            child: InkWell(
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color:Colors.black26,
                                         offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(w*0.03, w*0.015, w*0.02, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Date : ${DateFormat(
                                                            'dd-MM-yyyy hh:mm')
                                                            .format(data[index]['createdDate'].toDate()
                                                        )
                                                            .toString()}',
                                                        style:
                                                        TextStyle(
                                                          fontFamily: 'Lexend Deca',
                                                          color: Color(0xFF355967),
                                                          fontSize: w*0.029,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        data[index]['complaint'],
                                                        style:
                                                        TextStyle(
                                                          fontFamily: 'Lexend Deca',
                                                          color: Color(0xFF090F13),
                                                          fontSize: w*0.038,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Card(
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                     color: Color(0xFFF1F4F8),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                                            child:
                                                      Container(
                                                        width: w*0.12,
                                                        height: w*0.12,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: data[index]['OwnerImage'] == null ? Image.asset(
                                                          'assets/images/noProfile.png',
                                                          fit: BoxFit.cover,
                                                        ):

                                                        Image.network(data[index]['OwnerImage']
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(w*0.038, 4, w*0.02, 3),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Building : ${data[index]["flatName"]}',
                                                      style: TextStyle(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Color(0xFF95A1AC),
                                                        fontSize: w*0.04,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(w*0.038, 0, w*0.02, 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Floor : G | 1004',
                                                      style: TextStyle(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Color(0xFF95A1AC),
                                                        fontSize: w*0.04,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: w*0.025,),
                                           data[index]['status'] == 6 ?       Expanded(
                                                    child:Text(
                                                      'Re requested',
                                                      style: TextStyle(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Colors.red,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w900,
                                                      ),
                                                    ),
                                                  ) :SizedBox()

                                                  ,


                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.black,
                                                    size: w*0.055,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ),
                          ),
                              onTap:() {
                               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                 return ComplaintsViewPage(id: data[index]['id'],
                                 );
                               },));
                              },
                            )
                          );
                          InkWell(
                          child: Container(
                            width: w * 0.95,
                            height: w * 0.5,
                            padding: EdgeInsets.all(w*0.02),
                            margin: EdgeInsets.only(bottom:w*0.03),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(0, 4)),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [


                                SizedBox(width: w*0.03,),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index]["complaint"],
                                      style:GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: w*0.04
                                      ) ,),
                                    Row(
                                      children: [

                                        SvgPicture.asset( "assets/images/oyyovilla.svg",
                                          height: w*0.04,
                                          width: w*0.04,
                                        ),

                                        SizedBox(width:w* 0.02,),
                                        Text(data[index]["flatName"],
                                          style:GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: w*0.04
                                          ) ,),

                                      ],
                                    ),

                                    Row(
                                      children: [

                                        SvgPicture.asset( "assets/images/date.svg",
                                          height: w*0.04,
                                          width: w*0.04,
                                        ),

                                        SizedBox(width:w* 0.02,),
                                        Text(
                                            'Date :' +
                                                DateFormat(
                                                    'dd-MM-yyyy hh:mm')
                                                    .format(data[index]['createdDate'].toDate()
                                                    )
                                                    .toString(),
                                          style:GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: w*0.04
                                            ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [

                                        SvgPicture.asset( "assets/images/phone.svg",
                                          height: w*0.03,
                                          width: w*0.03,
                                        ),

                                        SizedBox(width:w* 0.02,),
                                        Text("9645659547",
                                          style:GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: w*0.04
                                          ) ,),

                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                          },
                        );
                      },


                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
