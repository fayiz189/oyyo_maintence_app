import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oyyo_maintence_app/Navpages/maintenanceList.dart';


class ContractViewWidget extends StatefulWidget {
  final String id;
  final Map contract;

  const ContractViewWidget({Key? key, required this.id, required this.contract})
      : super(key: key);

  @override
  _ContractViewWidgetState createState() => _ContractViewWidgetState();
}

class _ContractViewWidgetState extends State<ContractViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    paymentSchedule = widget.contract['paymentSchedule'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  List paymentSchedule = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                  child: Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Colors.black,
                                        size: 21,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'Contract Details',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    widget.contract['buildingName'].toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Floor : ${widget.contract['floorName']} | ${widget.contract['flatName']}',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Rent : ${widget.contract['rentAmount'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 190, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x5B000000),
                              offset: Offset(0, -2),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Starting Date : ${DateFormat('dd-MM-yyyy').format(widget.contract['date'].toDate()).toString()}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: mainColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'Expiry Date : ${DateFormat('dd-MM-yyyy').format(widget.contract['contractPeriod'].toDate()).toString()}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: mainColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                                  child: Container(
                                    width: double.infinity,
                                    // height: 330,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color(0x33000000),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 12, 0, 4),
                                          child: Text(
                                            'Payment Schedule ',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: mainColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 0, 0),
                                          child: Text(
                                            'Summary',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 0),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: paymentSchedule.length,
                                            itemBuilder: (context, int index) {
                                              return Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 1),
                                                child: Container(
                                                  width: 100,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 0,
                                                        color: Color(0xFFE0E3E7),
                                                        offset: Offset(0, 1),
                                                      )
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 2),
                                                    child: Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              16, 8, 0, 8),
                                                          child: Container(
                                                            width: 4,
                                                            height: 100,
                                                            decoration:
                                                            BoxDecoration(
                                                              color:
                                                              Color(0xFF4B39EF),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(12,
                                                                12, 12, 0),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      4),
                                                                  child: Text(
                                                                    'Due Date : ${DateFormat('dd-MM-yyyy').format(paymentSchedule[index]['dueDate'].toDate()).toString()}',
                                                                    style:
                                                                    TextStyle(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      4),
                                                                  child: Text(
                                                                    'Payment Date : ${DateFormat('dd-MM-yyyy').format(paymentSchedule[index]['paymentDate'].toDate()).toString()}',
                                                                    style:
                                                                    TextStyle(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          4),
                                                                      child: Text(
                                                                        'Amount : ${paymentSchedule[index]['amount'].toStringAsFixed(2)}',
                                                                        style:
                                                                        TextStyle(
                                                                          fontFamily:
                                                                          'Outfit',
                                                                          color: Color(
                                                                              0xFF57636C),
                                                                          fontSize:
                                                                          14,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      8,
                                                                      0,
                                                                      0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Container(
                                                                        width: 120,
                                                                        height: 40,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: Color(
                                                                              0xFF25C365),
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              17),
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                          children: [
                                                                            Text(
                                                                              'Paid',
                                                                              style: TextStyle(
                                                                                  fontFamily: 'Urbanist',
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Icon(
                                                                              Icons
                                                                                  .check_circle,
                                                                              color:
                                                                              Colors.white,
                                                                              size:
                                                                              20,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ),
        );
  }
}