



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oyyo_maintence_app/Navpages/complaint.dart';
import 'package:oyyo_maintence_app/Navpages/history.dart';
import 'package:oyyo_maintence_app/Navpages/maintenanceList.dart';
import 'package:oyyo_maintence_app/Navpages/stock.dart';
import 'package:oyyo_maintence_app/const.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = FirstPage();
  int _index = 0;
  var mainColor= Color(0xFF084586);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: mainColor,
            extendBody: true,
            body: PageStorage(
              bucket: _bucket,
              child: _currentScreen,
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                   bottom: scrWidth * 0.05),
              child: Container(
                width: scrWidth * .85,
                // height: 72,
                height: scrWidth * .17,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        offset: const Offset(0, 4),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(scrWidth * 0.6),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _index = 0;
                            _currentScreen = FirstPage();
                          });
                        },
                        minWidth: scrWidth * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _index == 0
                                ? SvgPicture.asset(
                              "assets/images/Home.svg",
                              height: size20,
                              width: size20,
                              color: mainColor,
                            )
                                : SvgPicture.asset(
                              "assets/images/home 2..svg",
                              height: size20,
                              width: size20,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: scrWidth * 0.02,
                            ),
                            Text(
                              'HOME',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSize12,
                                  color: _index == 0
                                      ? mainColor
                                      : Colors.grey),
                              // style: TextStyle(
                              //   color: _index == 0
                              //       ? navBarSelectedColor
                              //       : navBarUnSelectedColor,
                              //   fontWeight: FontWeight.w500,
                              // ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _index = 1;
                            // _currentScreen = Expense();
                            // _currentScreen = History();
                            _currentScreen = History();

                          });
                        },
                        minWidth: scrWidth * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _index == 1
                                ? SvgPicture.asset(
                              "assets/images/history2.svg",
                              height: size20,
                              width: size20,
                              color: mainColor,
                            )
                                : SvgPicture.asset(
                              "assets/images/Layer 62.svg",
                              height: size20,
                              width: size20,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: scrWidth * 0.02,
                            ),
                            Text(
                              'HISTORY',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSize12,
                                  color: _index == 1
                                      ?  mainColor
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _index = 2;
                            // _currentScreen = Expense();
                            _currentScreen = Stock();
                          });
                        },
                        minWidth: scrWidth * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _index == 2
                                ? SvgPicture.asset(
                              "assets/images/stockicon.svg",
                              height: size20,
                              width: size20,
                              color: mainColor,
                            )
                                : SvgPicture.asset(
                              "assets/images/stockicon.svg",
                              height: size20,
                              width: size20,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: scrWidth * 0.02,
                            ),
                            Text(
                              'STOCK',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSize12,
                                  color: _index == 2
                                      ? mainColor
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
    );
    }
}