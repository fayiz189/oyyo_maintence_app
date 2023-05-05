import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import 'package:oyyo_maintence_app/Navpages/productWidget.dart';
import 'package:oyyo_maintence_app/const.dart';
import 'package:oyyo_maintence_app/main.dart';
import 'package:oyyo_maintence_app/utils/audio_player.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'dart:io';

import 'package:oyyo_maintence_app/utils/showSnackbar.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

import '../utils/Imageviewer.dart';

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
  List<Map<String,dynamic>>  inventory = [];
  Map<String, dynamic> productDatabyName = {};
  Map<String, dynamic> productPricebyName = {};


  final List _selectedImages = [];

  Future<void> _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
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


  Future<void> _pickImageGallery() async {
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

  List products = [];
  List<String> productsList = [];

  QuerySnapshot? stockSnapshot;
  getProducts(){
    FirebaseFirestore.instance.collectionGroup('stock').
    where('headId',isEqualTo: currentUserHeadId ).snapshots().listen((event) {

      stockSnapshot=event;
      productsList.clear();
      products.clear();
      for(var doc in event.docs){

        products.add(doc.data());
        productsList.add(doc.get('productName'));
        productDatabyName[doc.get('productName')] = doc.data();


      }
      if (mounted) {
       setState(() {

       });
      }


    });
  }
  QuerySnapshot? inventoryList;


  getInventory(){

    FirebaseFirestore.instance.collectionGroup('inventory').where('complaintId',isEqualTo: widget.id)
        .snapshots().listen((event) {


        inventoryList=event;


      if (mounted) {
        setState(() {

        });

      }


    });
  }

  getProductPrice(){
    FirebaseFirestore.instance.collection('products').snapshots().listen((event) {
      for(var doc in event.docs){
        productPricebyName[doc.get('productName')] = doc.get('price');


      }
      if (mounted) {
        setState(() {

        });

      }

    });
  }
 final productController = TextEditingController();
 final quantity = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    getProductPrice();
    getInventory();
  }
  List<String> qtyList=['Choose Product'];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data;
                    return Stack(
                      children: [
                        Container(
                          // width: MediaQuery.of(context).size.width,
                          height: w*0.58,
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
                                        width: w*0.09,
                                        height: w*0.09,
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
                                            size: w*0.06,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          w*0.038, 0, 0, 0),
                                      child: Text(
                                        data!['complaint'],
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.white,
                                          fontSize: w*0.05 ,
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
                                        data['flatName'].toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: w*0.055,
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
                                  data['floorName'],
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: w*0.039,
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
                                          fontSize: w*0.039
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, w*0.5, 0, 0),
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
                                      w*0.036, w*0.038, w*0.036, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              w*0.02, 0, 0, 0),
                                          child: Text(
                                            'Created Date : ${DateFormat('dd-MM-yyyy').format(
                                                data['createdDate'].toDate()).toString()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: mainColor,
                                              fontSize: w*0.033,
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
                                            height: w*0.8,
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
                                                            fontSize: w*0.04),
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
                                                            fontSize: w*0.04),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Created Date : ${DateFormat('dd-MM-yyyy').format(
                                                            data['createdDate'].toDate()).toString()}',
                                                        style: GoogleFonts.inter(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: w*0.04),
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
                                                            fontSize: w*0.04),
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
                                                        height: w*0.27,
                                                        width: w*0.8,
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
                                                                height: w*0.02,
                                                                width:w*0.4,
                                                                 // decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),),
                                                                child: InkWell(
                                                                  child: Image.network(
                                                                      data['images']
                                                                          [index], fit: BoxFit.fitWidth,),
                                                                  onTap: () {

                                                                    final img = data['images'][index];

                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              MyImage(imge: img),
                                                                        ));
                                                                    // MultiImageProvider multiImageProvider =
                                                                    // MultiImageProvider(List.generate(data['images'].length,
                                                                    //       (index) => Image.network(data['images'][index]).image,));
                                                                    // showImageViewerPager(context, multiImageProvider,
                                                                    //     swipeDismissible: true, doubleTapZoomable: true);

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
                                                  fontSize: w*0.037,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ): SizedBox(),

                                          SizedBox(height: w*0.03,),

                                      data['reRequest'] == true || data['status'] == 4  ? Container(
                                            height: w*0.38,
                                            width: w*0.8,
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
                                                      height: w*0.1,
                                                      width: w*0.3,
                                                      child: InkWell(
                                                        child: Image.network(
                                                            data['workerImage'][
                                                            index],fit: BoxFit.contain),

                                                        onTap: () {
                                                          final img = data['workerImage'][index];

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyImage(imge: img),
                                                              ));


                                                          // MultiImageProvider multiImageProvider =
                                                          // MultiImageProvider(List.generate( data['workerImage'].length,
                                                          //       (index) => Image.network( data['workerImage'][index]).image,));
                                                          // showImageViewerPager(context, multiImageProvider,
                                                          //     swipeDismissible: true, doubleTapZoomable: true);
                                                        },
                                                      ),
                                                    )),
                                          ) :SizedBox(),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(
                                                left: 17, right: 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),

                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics: BouncingScrollPhysics(),
                                                itemCount: data['audio'].length,
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
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    imageupload==true? CircularProgressIndicator():
                                                    InkWell(
                                                      onTap: () {
                                                        imageupload=true;
                                                        setState(() {

                                                        });
                                                        _pickImageCamera();
                                                      },
                                                      child: CircleAvatar(
                                                        radius: w*0.075,
                                                        backgroundColor: mainColor,
                                                        child: SvgPicture.asset(
                                                            'assets/images/camIcon.svg',
                                                            color: Colors.white,
                                                            height: w * 0.05),
                                                      ),
                                                    ),
                                                    SizedBox(width: scrWidth* 0.05,),
                                                    InkWell(
                                                      onTap: () {
                                                        imageupload=true;
                                                        setState(() {

                                                        });
                                                        _pickImageGallery();
                                                      },
                                                      child: CircleAvatar(
                                                        radius: w*0.075,
                                                        backgroundColor: mainColor,
                                                        child: Icon(Icons.file_upload_outlined,color: Colors.white,),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(height: scrWidth*0.07,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 19),
                                                  child:  Wrap(
                                                      children: List.generate(
                                                          _selectedImages.length,
                                                              (index) {
                                                            final img = _selectedImages[index];
                                                            return InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          MyImage(imge: img),
                                                                    ));
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(15),
                                                                child:
                                                                Stack(
                                                                  clipBehavior: Clip.none,
                                                                  children: [
                                                                    Container(
                                                                      height: 70,
                                                                      width: 80,
                                                                      child:
                                                                      Image.network(
                                                                        _selectedImages[index],
                                                                        fit: BoxFit.cover,),
                                                                    ),
                                                                    Positioned(
                                                                        bottom: 60,
                                                                        left: 70,
                                                                        child: InkWell(
                                                                          onTap: () async {
                                                                            bool proceed = await alert(
                                                                                context, 'Do You want to delete this image');
                                                                            if (proceed) {
                                                                              setState(() {
                                                                                _selectedImages.removeAt(index);

                                                                              });
                                                                              showUploadMessage(context, 'image deleted');

                                                                            }



                                                                          },
                                                                          child: CircleAvatar(
                                                                              backgroundColor: Colors.grey,
                                                                              radius: 10,
                                                                              child: Icon(Icons.close,color: Colors.red,size: 15,)),
                                                                        )),

                                                                  ],
                                                                ) ,
                                                              ),
                                                            );
                                                          })),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(),


                                 data['status']  == 3 ?     Column(
                                            children: [

                                              SizedBox(height: 20,),
                                              Container(
                                                margin: const EdgeInsets.only(left: 40 ,right: 40),
                                                height: w*0.14,
                                                width: w*0.8,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x4D101213),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: CustomDropdown.search(
                                                  hintText: 'Choose a Product',
                                                  hintStyle: const TextStyle(),
                                                  items: productsList,
                                                  controller: productController,
                                                  excludeSelected: false,
                                                  onChanged: (text) {
                                                    ////////////

                                                    qtyList.clear();
                                                    quantity.clear();
                                                    if(productDatabyName[productController.text]['quantity']==0){
                                                      qtyList=['Out of Stock'];
                                                    }else{
                                                      for(int i=0;i<productDatabyName[productController.text]['quantity'];i++){
                                                        qtyList.add((i+1).toString());

                                                      }
                                                    }


                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                margin: const EdgeInsets.only(left: 40,right: 40),
                                                height: w*0.14,
                                                width: w*0.8,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: Color(0x4D101213),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: CustomDropdown.search(
                                                  hintText: 'Choose a quantity',
                                                  hintStyle: const TextStyle(),
                                                  items: qtyList,
                                                  controller: quantity,
                                                  excludeSelected: false,
                                                  onChanged: (text) {
                                                    ////////////
                                                    if(text=='Out of Stock'){
                                                      quantity.clear();
                                                    }

                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsets.only(left: 20,right: 20),
                                              //   child: TextFormField(
                                              //     controller: quantity,
                                              //     maxLines: 3,
                                              //     obscureText: false,
                                              //     validator: (value) {
                                              //       if (value!.isEmpty) {
                                              //         return 'Please Enter quanitity';
                                              //       }
                                              //     },
                                              //     decoration: InputDecoration(
                                              //       labelText: 'quantity',
                                              //       labelStyle: TextStyle(
                                              //           fontFamily: 'Montserrat',
                                              //           color: Color(0xFF8B97A2),
                                              //           fontWeight: FontWeight.bold,
                                              //           fontSize: 12
                                              //       ),
                                              //       hintText: 'Please Enter quantity',
                                              //       hintStyle: TextStyle(
                                              //           fontFamily: 'Montserrat',
                                              //           color: Color(0xFF8B97A2),
                                              //           fontWeight: FontWeight.bold,
                                              //           fontSize: 12
                                              //
                                              //       ),
                                              //       enabledBorder:
                                              //       UnderlineInputBorder(
                                              //         borderSide: BorderSide(
                                              //           color: Colors.transparent,
                                              //           width: 1,
                                              //         ),
                                              //         borderRadius:
                                              //         const BorderRadius.only(
                                              //           topLeft:
                                              //           Radius.circular(4.0),
                                              //           topRight:
                                              //           Radius.circular(4.0),
                                              //         ),
                                              //       ),
                                              //       focusedBorder:
                                              //       UnderlineInputBorder(
                                              //         borderSide: BorderSide(
                                              //           color: Colors.transparent,
                                              //           width: 1,
                                              //         ),
                                              //         borderRadius:
                                              //         const BorderRadius.only(
                                              //           topLeft:
                                              //           Radius.circular(4.0),
                                              //           topRight:
                                              //           Radius.circular(4.0),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     style: TextStyle(
                                              //         fontFamily: 'Montserrat',
                                              //         color: Colors.black,
                                              //         fontWeight: FontWeight.bold,
                                              //         fontSize: 13
                                              //     ),
                                              //   ),
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15,right: 15),
                                                child: TextButton(onPressed: (){

                                                  int? qty = int.tryParse(quantity.text);
                                                  String pdt =productDatabyName[productController.text]['productId'];


                                                  if (productController.text != '' && quantity.text != '') {
                                                    FirebaseFirestore.instance
                                                        .collectionGroup(
                                                        'stock').where('headId',
                                                        isEqualTo: currentUserHeadId)
                                                        .get().then((value) {
                                                      for (var doc in value
                                                          .docs) {
                                                        if (pdt == doc
                                                            .data()['productId']) {
                                                          doc.reference.update({
                                                            "quantity": FieldValue
                                                                .increment(
                                                                -qty!)
                                                          });
                                                        }
                                                      }
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                        'complaints').doc(
                                                        data['id']).collection(
                                                        'inventory').add({

                                                      "productName": productController
                                                          .text,
                                                      "productId": productDatabyName[productController
                                                          .text]['productId'],
                                                      "quantity": int.tryParse(
                                                          quantity.text),
                                                      "price": double.tryParse(
                                                          productPricebyName[productController
                                                              .text]
                                                              .toString()),
                                                      "complaintId": data['id'],


                                                    }
                                                    ).then((value) {
                                                      value.update({
                                                        "id": value.id
                                                      });
                                                    });


                                                    productController.clear();
                                                    quantity.clear();

                                                    setState(() {

                                                    });
                                                  }
                                                  else {

                                                showUploadErrorMessage(context, 'Please choose quantity');
                                                setState(() {

                                                });





                                                  }


                                                }, child: Text('Add')),
                                              ),
                                              SizedBox(height: w*0.025,),

                                              inventoryList!.docs.isEmpty ? SizedBox():      Container(
                                                decoration: BoxDecoration(
                                                  color: mainColor,
                                                  borderRadius: BorderRadius.circular(20)
                                                ),

                                                width: double.infinity,
                                                height: w*0.78,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: inventoryList!.docs.length,
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      width: w*0.1,
                                                      height: 50,
                                                      // color: Colors.black,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(15),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('${index +1}.',style: TextStyle(color: Colors.white,fontSize: w*0.045),),
                                                            // SizedBox(width: 15,),
                                                            Text(inventoryList!.docs[index]['productName'],style: TextStyle(color: Colors.white),),
                                                            // SizedBox(width: 40,),
                                                            Text(inventoryList!.docs[index]['quantity'].toString(),style: TextStyle(color: Colors.white),),
                                                            // SizedBox(width: 15,),
                                                            Text(inventoryList!.docs[index]['price'].toString(),style: TextStyle(color: Colors.white),),

                                                            IconButton(onPressed: () async {
                                                              bool proceed = await alert(
                                                                  context,
                                                                  'Do You want Delete ?');

                                                              if (proceed) {
                                                                int qty = inventoryList!
                                                                    .docs[index]['quantity'];
                                                                for (var a in stockSnapshot!
                                                                    .docs) {
                                                                  if (inventoryList!
                                                                      .docs[index]['productId'] ==
                                                                      a['productId']) {
                                                                    a.reference
                                                                        .update(
                                                                        {
                                                                          "quantity": FieldValue
                                                                              .increment(
                                                                              qty)
                                                                        }
                                                                    );
                                                                  }
                                                                }
                                                                inventoryList!
                                                                    .docs[index]
                                                                    .reference
                                                                    .delete();
                                                                productController
                                                                    .clear();
                                                                quantity
                                                                    .clear();
                                                              }
                                                            }
                                                              , icon: Icon(Icons.delete,color: Colors.red,size: 20,)),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },),
                                              ),
                                              SizedBox(height: 10,),
                                            ],
                                          ):SizedBox(),



                                          Row(
                                            children: [
                                              data['status'] == 2
                                                  ? InkWell(
                                                      child: Container(
                                                        height: w*0.1,
                                                        width: w*0.38,
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
                                                                      w * 0.045)),
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
                                                width: w*0.04,
                                              ),
                                              data['status'] == 3
                                                  ? InkWell(
                                                      child: Container(
                                                        height: w * 0.09,
                                                        width: w * 0.38,
                                                        decoration: BoxDecoration(
                                                          color: mainColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Center(
                                                          child: Text(" Work Completed",
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .greenAccent,
                                                                  fontSize:
                                                                      w * 0.03)),
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
                                                              Navigator.pop(context);

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
      ),
    );
  }
}
