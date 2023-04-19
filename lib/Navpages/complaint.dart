import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:oyyo_maintence_app/Loging/login.dart';
import 'package:oyyo_maintence_app/Navpages/maintenanceList.dart';
import 'package:oyyo_maintence_app/main.dart';
import 'package:oyyo_maintence_app/utils/audio_player.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'dart:io';

import 'package:oyyo_maintence_app/utils/showSnackbar.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class ComplaintsViewPage extends StatefulWidget {
  final String id;
  ComplaintsViewPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ComplaintsViewPage> createState() => _ComplaintsViewPageState();
}

class _ComplaintsViewPageState extends State<ComplaintsViewPage> {
  var file;
  String? imgUrl;
  bool imageupload=false;


  final List _selectedImages = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      DocumentSnapshot id = await FirebaseFirestore.instance
          .collection('settings')
          .doc('settings')
          .get();
      id.reference.update({'imageId': FieldValue.increment(1)});

      int imageId = id['imageId'];

      imageId++;
      var ref = FirebaseStorage.instance.ref().child('complaints/$imageId');
      UploadTask uploadTask = ref.putFile(File(pickedFile.path));

      await uploadTask.then((res) async {
        imgUrl = (await ref.getDownloadURL()).toString();
      });
      setState(() {
        imageupload=false;
        _selectedImages.add(imgUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('complaints')
                    .doc(widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  print(currentUserID);
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data;
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        decoration: BoxDecoration(color: mainColor),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 2, 2, 2),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Text(
                                      data!['complaint'],
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      data!['flatName'].toUpperCase(),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'floorName',
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Customer Name : ' + data['ownerName'],
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Padding(
                              //     padding: EdgeInsetsDirectional.fromSTEB(0, 190, 0, 0),
                              //     child: Container(
                              //       width: MediaQuery.of(context).size.width,
                              //       decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         boxShadow: [
                              //           BoxShadow(
                              //             blurRadius: 4,
                              //             color: Color(0x5B000000),
                              //             offset: Offset(0, -2),
                              //           )
                              //         ],
                              //         borderRadius: BorderRadius.only(
                              //           bottomLeft: Radius.circular(0),
                              //           bottomRight: Radius.circular(0),
                              //           topLeft: Radius.circular(20),
                              //           topRight: Radius.circular(20),
                              //         ),
                              //       ),
                              //     )
                              // )
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          'Created Date : ${DateFormat('dd-MM-yyyy').format(data['createdDate'].toDate()).toString()}',
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 12, 16, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 350,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: mainColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Title  : ' +
                                                          data["complaint"],
                                                      style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Desc  : ' +
                                                          data["description"],
                                                      style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Number  : ' +
                                                          data["phone"],
                                                      style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Wrap(
                                                  children: [
                                                    Container(
                                                      height: 150,
                                                      width: 400,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            data['images']
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 75,
                                                              width: 75,
                                                              child: InkWell(
                                                                child: Image.network(
                                                                    data['images']
                                                                        [index]),
                                                                onTap: () {
                                                                  MultiImageProvider multiImageProvider =
                                                                  MultiImageProvider(List.generate(data['images'].length,
                                                                        (index) => Image.network(data['images'][index]).image,));
                                                                  showImageViewerPager(context, multiImageProvider,
                                                                      swipeDismissible: true, doubleTapZoomable: true);

                                                                  // ImageViewer.showImageSlider(
                                                                  //   startingPosition: 1,
                                                                  //     images:List.generate(data["images"].length, (index)
                                                                  //     => data['images'][index]));
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: w*0.03,),
                                        data['status']== 4 ? Row(
                                          children: [
                                            Text(
                                              data['endDate'] == ""? "":
                                              'Completed Date : ${DateFormat('dd-MM-yyyy').format(data['endDate'].toDate()).toString()}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: mainColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ): SizedBox(),

                                        SizedBox(height: w*0.03,),

                                    data['status'] == 4?     Container(
                                          height: 100,
                                          width: 250,
                                          decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12)),
                                          child: ListView.builder(
                                              scrollDirection:
                                              Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                              data['workerImage'].length,
                                              itemBuilder:
                                                  (context, index) =>
                                                  Container(
                                                    height: 70,
                                                    width: 100,
                                                    child: InkWell(
                                                      child: Image.network(
                                                          data['workerImage'][
                                                          index]),
                                                      onTap: () {
                                                        MultiImageProvider multiImageProvider =
                                                        MultiImageProvider(List.generate( data['workerImage'].length,
                                                              (index) => Image.network( data['workerImage'][index]).image,));
                                                        showImageViewerPager(context, multiImageProvider,
                                                            swipeDismissible: true, doubleTapZoomable: true);
                                                      },
                                                    ),
                                                  )),
                                        ) :SizedBox(),

                                        Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(
                                              left: 17, right: 17),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          height: 250,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: data!['audio'].length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          height: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: AudioPlayer(
                                                            source: ap
                                                                    .AudioSource
                                                                .uri(Uri.tryParse(
                                                                    data['audio']
                                                                        [
                                                                        index])!),
                                                            onDelete: () {},
                                                            message: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),



                                      data['status'] == 3 ?  Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                    color: mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        _selectedImages.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Container(
                                                              height: 70,
                                                              width: 100,
                                                              child: InkWell(
                                                                child: Image.network(
                                                                    _selectedImages[
                                                                        index]),
                                                                onTap: () {
                                                                  MultiImageProvider multiImageProvider =
                                                                  MultiImageProvider(List.generate( _selectedImages.length,
                                                                        (index) => Image.network( _selectedImages[index]).image,));
                                                                  showImageViewerPager(context, multiImageProvider,
                                                                      swipeDismissible: true, doubleTapZoomable: true);
                                                                },
                                                              ),
                                                            )),
                                              ),
                                              SizedBox(
                                                width: w * 0.04,
                                              ),
                                            imageupload==true? CircularProgressIndicator():
                                           InkWell(
                                                onTap: () {
                                                  imageupload=true;
                                                  setState(() {

                                                  });
                                                  _pickImage();
                                                },
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: mainColor,
                                                  child: SvgPicture.asset(
                                                      'assets/images/camIcon.svg',
                                                      color: Colors.white,
                                                      height: w * 0.035),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) : SizedBox(),
                                        Row(
                                          children: [
                                            data['status'] == 2
                                                ? InkWell(
                                                    child: Container(
                                                      height: 50,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            "Start Work",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    w * 0.02)),
                                                      ),
                                                    ),
                                                    onTap: () async {

                                                      bool proceed = await alert(
                                                          context, 'Do You want to start work?');
                                                      if(proceed){


                                                        FirebaseFirestore.instance
                                                            .collection(
                                                            'complaints')
                                                            .doc(data['id'])
                                                            .update({
                                                          "status": 3,
                                                        });
                                                        setState(() {});
                                                      }

                                                    },
                                                  ) : data['status'] == 6?InkWell(
                                              child: Container(
                                                height: 50,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      "Start Work",
                                                      style: GoogleFonts.inter(
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          w * 0.02)),
                                                ),
                                              ),
                                              onTap: () async {

                                                bool proceed = await alert(
                                                    context, 'Do You want to start work?');
                                                if(proceed){


                                                  FirebaseFirestore.instance
                                                      .collection(
                                                      'complaints')
                                                      .doc(data['id'])
                                                      .update({
                                                    "status": 3,
                                                  });
                                                  setState(() {});
                                                }

                                              },
                                            )
                                                : SizedBox(),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            data['status'] == 3
                                                ? InkWell(
                                                    child: Container(
                                                      height: w * 0.07,
                                                      width: w * 0.15,
                                                      decoration: BoxDecoration(
                                                        color: mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Center(
                                                        child: Text("End work ",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    w * 0.02)),
                                                      ),
                                                    ),
                                                    onTap: () async {

                                                      bool proceed = await alert(
                                                          context, 'Do You want to End Work?');

                                                        if (imgUrl == null) {
                                                          showUploadMessage(
                                                              context,
                                                              'please upload image',);
                                                        } else {

                                                          if(proceed){


                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                'complaints')
                                                                .doc(data['id'])
                                                                .update(
                                                                {

                                                                  "status": 4,
                                                                  "endDate" : DateTime.now(),
                                                                  "workerImage": _selectedImages,

                                                                });
                                                            setState(() {});
                                                            showUploadMessage(context, 'Work completed!',);

                                                          }


                                                        }





                                                    },
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
