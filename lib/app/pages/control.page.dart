
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'waterlog.page.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      body: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(84), left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Waterlog',
              style: GoogleFonts.nunito(
                fontSize: ScreenUtil().setSp(18),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WaterlogPage(),
                  ),
                );
              },
              child: Icon(
                Icons.chevron_right,
                size: ScreenUtil().setSp(26),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}