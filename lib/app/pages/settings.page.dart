import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sendfeedback.page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.nunito(
            fontSize: ScreenUtil().setSp(17),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            fontFeatures: [
              const FontFeature.enable('clig'),
              const FontFeature.enable('liga'),
            ],
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(210, 59, 106, 1)),
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(44),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          const CardWidget(
            title: 'Share with friends',
            description: 'Invite your friends to our app',
          ),
          const CardWidget(
            title: 'Rate the app',
            description: 'Please take a moment to rate it',
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendFeedbackPage(),
                ),
              );
            },
            child: const CardWidget(
              title: 'Feedback',
              description: 'Help us improve the experience',
            ),
          ),
          const CardWidget(
            title: 'Version',
            description: '0.1.0',
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String description;

  const CardWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(361),
      height: ScreenUtil().setHeight(62),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.55),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
      ),
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16),
        top: ScreenUtil().setHeight(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(16),
          top: ScreenUtil().setHeight(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              description,
              style: GoogleFonts.nunito(
                fontSize: ScreenUtil().setSp(13),
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
