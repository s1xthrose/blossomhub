import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WateringProvider extends ChangeNotifier {
  Map<String, List<FlowerData>> wateringRecords = {};

  void addOrUpdateRecord(FlowerData record) {
    if (!wateringRecords.containsKey(record.flowerId)) {
      wateringRecords[record.flowerId] = [record];
    } else {
      wateringRecords[record.flowerId]!.add(record);
    }
    notifyListeners();
  }
}

class FlowerData {
  String flowerId;
  String flowerName;
  DateTime lastWateringDate;
  int wateringFrequencyInDays;
  String imageUrl;

  FlowerData({
    required this.flowerId,
    required this.flowerName,
    required this.lastWateringDate,
    required this.wateringFrequencyInDays,
    required this.imageUrl,
  });
}

class WateringSchedulePage extends StatefulWidget {
  final String flowerId;
  final String flowerName;
  final String imageUrl;
  final DateTime lastWateringDate;
  final int wateringFrequencyInDays;

  const WateringSchedulePage({super.key, 
    required this.flowerId,
    required this.flowerName,
    required this.imageUrl,
    required this.lastWateringDate,
    required this.wateringFrequencyInDays,
  });

  @override
  _WateringSchedulePageState createState() => _WateringSchedulePageState();
}

class _WateringSchedulePageState extends State<WateringSchedulePage> {
  late DateTime _lastWateringDate;
  late WateringProvider wateringProvider;
  late String _flowerId;

  @override
  void initState() {
    super.initState();
    wateringProvider = context.read<WateringProvider>();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _flowerId = widget.flowerId;
      _lastWateringDate =
          DateTime.parse(prefs.getString('lastWateringDate$_flowerId') ??
              widget.lastWateringDate.toString());
      wateringProvider.addOrUpdateRecord(FlowerData(
        flowerId: _flowerId,
        flowerName: widget.flowerName,
        lastWateringDate: _lastWateringDate,
        wateringFrequencyInDays: widget.wateringFrequencyInDays,
        imageUrl: widget.imageUrl,
      ));
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastWateringDate$_flowerId', _lastWateringDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));

    DateTime nextWateringDate =
    _lastWateringDate.add(Duration(days: widget.wateringFrequencyInDays));
    int daysUntilNextWatering =
        nextWateringDate.difference(DateTime.now()).inDays;
    int daysSinceLastWatering =
        DateTime.now().difference(_lastWateringDate).inDays;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(210, 59, 106, 1)),
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(44),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.flowerName,
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Text(
                        'Watering frequency',
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(210, 59, 106, 0.7),
                        ),
                      ),
                      Text(
                        'Every ${widget.wateringFrequencyInDays} days',
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(13),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Text(
                        'Last watering date',
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(210, 59, 106, 0.7),
                        ),
                      ),
                      Text(
                        '${DateFormat('dd MMMM yyyy').format(
                          _lastWateringDate.toLocal(),
                        )} '
                            '($daysSinceLastWatering days ago)',
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(13),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Text(
                        'Next watering date',
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(210, 59, 106, 0.7),
                        ),
                      ),
                      Text(
                        '${DateFormat('dd MMMM yyyy').format(
                          nextWateringDate.toLocal(),
                        )} '
                            '(in $daysUntilNextWatering days)',
                        style: GoogleFonts.nunito(
                          fontSize: ScreenUtil().setSp(13),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(72)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(12),
                    ),
                    child: widget.imageUrl.isNotEmpty && File(widget.imageUrl).existsSync()
                        ? Image.file(
                      File(widget.imageUrl),
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(100),
                    )
                        : Image.asset(
                      'assets/placeholder_image.png',
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(100),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Text(
              'Records',
              style: GoogleFonts.nunito(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(210, 59, 106, 0.7),
              ),
            ),
            Column(
              children: _buildRecordsList(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
        child: SizedBox(
          width: ScreenUtil().setWidth(229),
          height: ScreenUtil().setHeight(45),
          child: ElevatedButton(
            onPressed: () {
              _makeWateringToday();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(210, 59, 106, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(100),
                ),
              ),
            ),
            child: Text(
              'Made watering today',
              style: GoogleFonts.nunito(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecordsList() {
    List<Widget> recordsWidgets = [];

    if (wateringProvider.wateringRecords.containsKey(_flowerId)) {
      List<FlowerData> records = wateringProvider.wateringRecords[_flowerId]!;

      for (FlowerData record in records) {
        recordsWidgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watering',
                  style: GoogleFonts.nunito(
                    fontSize: ScreenUtil().setSp(13),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(
                    record.lastWateringDate.toLocal(),
                  ),
                  style: GoogleFonts.nunito(
                    fontSize: ScreenUtil().setSp(13),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );

        recordsWidgets.add(
          Divider(
            height: ScreenUtil().setHeight(1),
            color: const Color.fromRGBO(70, 180, 48, 0.7),
          ),
        );
      }

      if (recordsWidgets.isNotEmpty) {
        recordsWidgets.removeLast();
      }
    }

    return recordsWidgets;
  }

  _makeWateringToday() {
    setState(() {
      FlowerData flowerData = FlowerData(
        flowerId: _flowerId,
        flowerName: widget.flowerName,
        lastWateringDate: DateTime.now(),
        wateringFrequencyInDays: widget.wateringFrequencyInDays,
        imageUrl: widget.imageUrl,
      );

      wateringProvider.addOrUpdateRecord(flowerData);
      _lastWateringDate = DateTime.now();
      _saveData();
      //_loadData();
    });
  }
}
