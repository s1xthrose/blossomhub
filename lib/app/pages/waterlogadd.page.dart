import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'wateringschedule.page.dart';
import 'yourflow.page.dart';

class Watering {
  final String flowerId;
  final DateTime lastWateringDate;
  final int wateringFrequencyInDays;

  Watering({
    required this.flowerId,
    required this.lastWateringDate,
    required this.wateringFrequencyInDays,
  });
}

class WaterlogAddPage extends StatelessWidget {
  final TextEditingController lastWateringController = TextEditingController();
  final TextEditingController wateringFrequencyController = TextEditingController();

  WaterlogAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        title: Text(
          'Add flower',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YourFlowersDropdown(),
            SizedBox(height: ScreenUtil().setHeight(16)),
            TextField(
              controller: lastWateringController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: '',
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
                labelText: 'Last watering date',
                labelStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: const Color.fromRGBO(70, 180, 48, 1),
                  ),
                ),
                hintStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: const Color.fromRGBO(70, 180, 48, 1),
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
            SizedBox(height: ScreenUtil().setHeight(30)),
            TextField(
              controller: wateringFrequencyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '',
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
                labelText: 'Watering frequency (in days)',
                labelStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: const Color.fromRGBO(70, 180, 48, 1),
                  ),
                ),
                hintStyle: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: const Color.fromRGBO(70, 180, 48, 1),
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
            SizedBox(height: ScreenUtil().setHeight(16)),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: ScreenUtil().setWidth(56),
        height: ScreenUtil().setHeight(56),
        child: FloatingActionButton(
          onPressed: () {
            createWateringSchedule(context);
          },
          backgroundColor: const Color.fromRGBO(210, 59, 106, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: ScreenUtil().setSp(32),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void createWateringSchedule(BuildContext context) {
    Flower? selectedFlower = Provider.of<FlowerNotifier>(context, listen: false).selectedFlower;

    if (selectedFlower != null) {
      String flowerName = selectedFlower.name;

      DateTime lastWateringDate = DateFormat('dd.MM.yyyy').parse(lastWateringController.text);
      int wateringFrequency = int.parse(wateringFrequencyController.text);

      Watering watering = Watering(
        flowerId: selectedFlower.id,
        lastWateringDate: lastWateringDate,
        wateringFrequencyInDays: wateringFrequency,
      );

      print('Navigating to WateringSchedulePage with flowerName: $flowerName');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WateringSchedulePage(
            flowerId: selectedFlower.id,
            flowerName: flowerName,
            imageUrl: selectedFlower.imageUrl,
            lastWateringDate: lastWateringDate,
            wateringFrequencyInDays: wateringFrequency,
          ),
        ),
      );
    } else {
      print('Selected flower is null');
    }
  }
}

class YourFlowersDropdown extends StatefulWidget {
  const YourFlowersDropdown({Key? key}) : super(key: key);

  @override
  _YourFlowersDropdownState createState() => _YourFlowersDropdownState();
}

class _YourFlowersDropdownState extends State<YourFlowersDropdown> {
  Flower? selectedFlower;

  @override
  Widget build(BuildContext context) {
    var flowerNotifier = Provider.of<FlowerNotifier>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flower',
          style: GoogleFonts.nunito(
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(210, 59, 106, 0.7),
          ),
        ),
        GestureDetector(
          onTap: () async {
            var result = await showModalBottomSheet<Flower>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(59)),
                  height: ScreenUtil().setHeight(476),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(235, 255, 240, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setWidth(32)),
                      topRight: Radius.circular(ScreenUtil().setWidth(32)),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: flowerNotifier.flowers.length,
                    itemBuilder: (context, index) {
                      final flower = flowerNotifier.flowers[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(top: ScreenUtil().setHeight(3), bottom: ScreenUtil().setHeight(4)),
                            leading: Padding(
                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(16), top: ScreenUtil().setHeight(4)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                                child: selectedFlower != null &&
                                    selectedFlower!.imageUrl.isNotEmpty &&
                                    File(selectedFlower!.imageUrl).existsSync()
                                    ? Image.file(
                                  File(selectedFlower!.imageUrl),
                                  fit: BoxFit.cover,
                                  width: ScreenUtil().setWidth(30),
                                  height: ScreenUtil().setHeight(30),
                                )
                                    : Image.asset(
                                  'assets/placeholder_image.png',
                                  fit: BoxFit.cover,
                                  width: ScreenUtil().setWidth(30),
                                  height: ScreenUtil().setHeight(30),
                                ),
                              ),
                            ),
                            title: Text(
                              flower.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              flower.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(flower);
                              setState(() {
                                selectedFlower = flower;
                                Provider.of<FlowerNotifier>(context, listen: false).selectFlower(flower);
                              });
                            },
                          ),
                          if (index < flowerNotifier.flowers.length - 1)
                            Divider(
                              color: const Color.fromRGBO(70, 180, 48, 1),
                              thickness: 1.0,
                              indent: ScreenUtil().setWidth(16),
                              endIndent: ScreenUtil().setWidth(16),
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
            );

            if (result != null) {
              setState(() {
                selectedFlower = result;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
            ),
            padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (selectedFlower != null)
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                        child: selectedFlower!.imageUrl.isNotEmpty &&
                            File(selectedFlower!.imageUrl).existsSync()
                            ? Image.file(
                          File(selectedFlower!.imageUrl),
                          fit: BoxFit.cover,
                          width: ScreenUtil().setWidth(30),
                          height: ScreenUtil().setHeight(30),
                        )
                            : Image.asset(
                          'assets/placeholder_image.png',
                          fit: BoxFit.cover,
                          width: ScreenUtil().setWidth(30),
                          height: ScreenUtil().setHeight(30),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedFlower!.name,
                            style: GoogleFonts.nunito(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            selectedFlower!.description,
                            style: GoogleFonts.nunito(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                Icon(
                  Icons.chevron_right,
                  size: ScreenUtil().setSp(26),
                  color: const Color.fromRGBO(210, 59, 106, 0.7),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
