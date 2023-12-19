import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'yourflow.page.dart';

class FlowerDetailsPage extends StatelessWidget {
  final Flower flower;

  const FlowerDetailsPage({super.key, required this.flower});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        title: Text(
          flower.name,
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
        padding: EdgeInsets.all(ScreenUtil().setWidth(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: ScreenUtil().setWidth(281),
                height: ScreenUtil().setHeight(281),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
                  child: FutureBuilder(
                    future: _loadImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Image.memory(
                          snapshot.data as Uint8List,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Container(
                          color: Colors.grey,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(36.0)),
            Text(
              flower.name,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(20),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            Text(
              flower.description,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            Text(
              'Notes',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: const Color.fromRGBO(210, 59, 106, 0.7),
                  fontSize: ScreenUtil().setSp(15),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(8.0)),
            Text(
              flower.notes ?? 'No notes available',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _loadImage() async {
    try {
      if (flower.imageUrl.isNotEmpty && File(flower.imageUrl).existsSync()) {
        File imageFile = File(flower.imageUrl);
        return await imageFile.readAsBytes();
      } else {
        ByteData byteData = await rootBundle.load('assets/placeholder_image.png');
        return byteData.buffer.asUint8List();
      }
    } catch (e) {
      print('Error loading image: $e');
      ByteData byteData = await rootBundle.load('assets/placeholder_image.png');
      return byteData.buffer.asUint8List();
    }
  }
}
