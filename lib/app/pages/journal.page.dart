import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'journalatricle.page.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 47.h),
            const JournalCardWidget(
              title: 'The Big Bloom—How Flowering Plants Changed the World',
              description:
              'Read a National Geographic magazine article about how flowering plants appeared during the Cretaceous period and get information, facts, and more about the flowers and the prehistoric world.',
            ),
            const JournalCardWidget(
              title: 'The Big Bloom—How Flowering Plants Changed the World',
              description:
              'Read a National Geographic magazine article about how flowering plants appeared during the Cretaceous period and get information, facts, and more about the flowers and the prehistoric world.',
            ),
            const JournalCardWidget(
              title: 'The Big Bloom—How Flowering Plants Changed the World',
              description:
              'Read a National Geographic magazine article about how flowering plants appeared during the Cretaceous period and get information, facts, and more about the flowers and the prehistoric world.',
            ),
          ],
        ),
      ),
    );
  }
}

class JournalCardWidget extends StatelessWidget {
  final String title;
  final String description;

  const JournalCardWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JournalArticlePage(),
          ),
        );
      },
      child: Container(
        width: ScreenUtil().setWidth(361),
        height: ScreenUtil().setHeight(209),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.55),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
          border: Border.all(
            color: const Color.fromRGBO(70, 180, 48, 0.70),
            width: 1.0,
          ),
        ),
        margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
          top: ScreenUtil().setHeight(22),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(11),
            right: ScreenUtil().setWidth(31),
            top: ScreenUtil().setHeight(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: ScreenUtil().setSp(17),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                description,
                style: GoogleFonts.nunito(
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
