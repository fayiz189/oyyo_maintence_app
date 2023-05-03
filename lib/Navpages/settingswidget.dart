import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oyyo_maintence_app/const.dart';

class SettingsTileWidget extends StatefulWidget {
  final String icon;
  final String name;

  SettingsTileWidget({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  State<SettingsTileWidget> createState() => _SettingsTileWidgetState();
}

class _SettingsTileWidgetState extends State<SettingsTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: scrWidth * 0.18,
        width: scrWidth,
        color: Colors.transparent,
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          widget.icon,
                          width: size24,
                          height: size24,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size20,
                        ),
                        Text(widget.name,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 25,
                    )

                    // SvgPicture.asset(
                    //   'assets/icons/brace.svg',
                    //   width: size15,
                    //   height: size15,
                    //   color: Colors.white,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: size24,
              ),
              Divider(
                thickness: 1.5,
                height: 0,
                color: Color(0xffE5E4E4),
              ),
              SizedBox(
                height: size15,
              ),
            ],
            ),
        );
    }
}