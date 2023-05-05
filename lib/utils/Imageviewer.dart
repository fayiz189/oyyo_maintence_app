import 'package:flutter/material.dart';

import '../const.dart';



class MyImage extends StatelessWidget {
  const MyImage({super.key, required this.imge});
  final String imge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: scrWidth * 0.9,
          width: scrWidth * 0.9,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imge), fit: BoxFit.contain)),
        ),
      ),
    );
  }
}