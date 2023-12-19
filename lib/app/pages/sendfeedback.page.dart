import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SendFeedbackPage extends StatelessWidget {
  const SendFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        title: Text(
          'Send Feedback',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(17),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(210, 59, 106, 1)),
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(44),
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: ScreenUtil().setHeight(10)),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Add some new feature to app...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(70, 180, 48, 1),
                    width: ScreenUtil().setWidth(1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(70, 180, 48, 1),
                    width: ScreenUtil().setWidth(1),
                  ),
                ),
                labelText: 'Feedback',
                labelStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: const Color.fromRGBO(70, 180, 48, 1),
                  ),
                ),
                hintStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.black,
                  ),
                ),
              ),
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thank you!'),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        },
        backgroundColor: const Color.fromRGBO(210, 59, 106, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
        ),
        child: const Icon(
          Icons.send,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
