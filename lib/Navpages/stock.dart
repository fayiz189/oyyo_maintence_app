import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oyyo_maintence_app/Navpages/maintenanceList.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            // height: w * 2.2,
            padding:
            EdgeInsets.only(left: w * 0.05, top: w * 0.05, right: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/oyyologo.png",
                  height: w * 0.16,
                  width: w * 0.2,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: w * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "HISTORY",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: w * 0.05),
                    ),
                    PopupMenuButton(

                      itemBuilder: (BuildContext ) {
                        return[
                          PopupMenuItem(
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Icon(
                                           Icons
                                          .radio_button_checked_rounded,
                                      color:  Colors
                                          .black
                                    ),
                                    SizedBox(width: w*0.03,),

                                    Text(
                                    'TODAY',
                                    style:
                                    GoogleFonts.inter(
                                        fontWeight: FontWeight.w500
                                    ),
                          ),
                                  ],
                                ),
                                SizedBox(height: w*0.04,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Icon(
                                        Icons
                                            .radio_button_off_rounded,
                                        color:  Colors
                                            .black
                                    ),
                                    SizedBox(width: w*0.03,),
                                    Text(
                                      'THIS WEEK',
                                      style:
                                      GoogleFonts.inter(
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: w*0.04,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Icon(
                                        Icons
                                            .radio_button_off_rounded,
                                        color:  Colors
                                            .black
                                    ),
                                    SizedBox(width: w*0.03,),
                                    Text(
                                      'THIS MONTH',
                                      style:
                                      GoogleFonts.inter(
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: w*0.04,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Icon(
                                        Icons
                                            .radio_button_off_rounded,
                                        color:  Colors
                                            .black
                                    ),
                                    SizedBox(width: w*0.03,),
                                    Text(
                                      'THIS YEAR',
                                      style:
                                      GoogleFonts.inter(
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),



                          )
                        ];
                      },
                      child: Container(
                        width: w * 0.17,
                        height: w * 0.17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                spreadRadius: 2,
                                offset: Offset(0, 4)),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                              "assets/images/filtter.svg",
                              width: w * 0.06,
                              height: w * 0.06),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: w * 0.04,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount:4,itemBuilder:(context, index) {
                  return Container(
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
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //     height:w*0.35,
                        //     width: w*0.35,
                        //     child: GridView.builder(shrinkWrap: true,
                        //       itemCount: 4,
                        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 2,
                        //         crossAxisSpacing: 5,
                        //         mainAxisSpacing: 5,
                        //       ),
                        //       itemBuilder:(BuildContext, index) {
                        //         return ClipRRect(
                        //           borderRadius: BorderRadius.circular(7),
                        //           child: Container(
                        //             width: 20,
                        //             height: 20,
                        //             child: Image.asset(
                        //               "assets/images/pipeleak.png",),
                        //           ),
                        //         );
                        //       },
                        //     )
                        // ),

                        SizedBox(width: w*0.03,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("COMPLAINT",
                                      style:GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: w*0.04
                                      ) ,),
                                    // SizedBox(width: w*0.17,),
                                    Container(
                                      width: w * 0.06,
                                      height: w * 0.06,
                                        color: Colors.white,
                                      child: Center(
                                        child: SvgPicture.asset(
                                            "assets/images/green tick.svg",
                                            width: w * 0.06,
                                            height: w * 0.06),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text("Kichen Water Pipe Leak",
                              style:GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: w*0.04
                              ) ,),
                            Row(
                              children: [

                                SvgPicture.asset( "assets/images/oyyovilla.svg",
                                  height: w*0.04,
                                  width: w*0.04,
                                ),

                                SizedBox(width:w* 0.02,),
                                Text("OYYOVILLA",
                                  style:GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: w*0.04
                                  ) ,),

                              ],
                            ),

                            Row(
                              children: [

                                SvgPicture.asset( "assets/images/12B.svg",
                                  height: w*0.04,
                                  width: w*0.04,
                                ),

                                SizedBox(width:w* 0.02,),
                                Text("12B",
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
                                Text("27-03-2023",
                                  style:GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: w*0.04
                                  ) ,),

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
                  );
                },


                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
