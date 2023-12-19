import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flower_details_page.dart';
import 'yourfloweradd.page.dart';

class Flower {
  final String name;
  final String description;
  final String imageUrl;
  final String notes;
  final String id; // Add an 'id' property

  Flower({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.notes,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'notes': notes,
      'id': id,
    };
  }

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      notes: json['notes'],
      id: json['id'],
    );
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  factory Flower.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Flower.fromJson(jsonMap);
  }
}

class FlowerNotifier extends ChangeNotifier {
  List<Flower> _flowers = [];
  Flower? _selectedFlower;

  List<Flower> get flowers => _flowers;
  Flower? get selectedFlower => _selectedFlower;

  set flowers(List<Flower> flowers) {
    _flowers = flowers;
    notifyListeners();
  }

  void addFlower(Flower flower) {
    _flowers.add(flower);
    notifyListeners();
  }

  void selectFlower(Flower flower) {
    _selectedFlower = flower;
    notifyListeners();
  }
}

class YourFlowPage extends StatelessWidget {
  const YourFlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const YourFlowPageContent();
  }
}

class YourFlowPageContent extends StatelessWidget {
  const YourFlowPageContent({Key? key}) : super(key: key);

  void _loadFlowers(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? flowerList = prefs.getStringList('flowers');

    if (flowerList != null) {
      List<Flower> flowers = flowerList.map((jsonString) => Flower.fromJsonString(jsonString)).toList();
      Provider.of<FlowerNotifier>(context, listen: false).flowers = flowers;
    }
  }

  Future<Uint8List> _getResizedImage(String imageUrl) async {
    if (imageUrl.isNotEmpty && File(imageUrl).existsSync()) {
      File imageFile = File(imageUrl);
      return await imageFile.readAsBytes();
    }

    ByteData byteData = await rootBundle.load('assets/placeholder_image.png');
    return byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    _loadFlowers(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        title: Text(
          'Your flowers',
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
      body: Consumer<FlowerNotifier>(
        builder: (context, flowerNotifier, child) {
          return ListView.builder(
            itemCount: flowerNotifier.flowers.length,
            itemBuilder: (context, index) {
              final flower = flowerNotifier.flowers[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16.0),
                  vertical: ScreenUtil().setHeight(8.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
                ),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlowerDetailsPage(flower: flower),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: ScreenUtil().setWidth(393.0),
                    height: ScreenUtil().setHeight(155.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(8.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
                            child: FutureBuilder(
                              future: _getResizedImage(flower.imageUrl),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return Image.memory(
                                    snapshot.data as Uint8List,
                                    fit: BoxFit.cover,
                                    width: ScreenUtil().setWidth(139.0),
                                    height: ScreenUtil().setHeight(137.0),
                                  );
                                } else {
                                  return Container(
                                    width: ScreenUtil().setWidth(139.0),
                                    height: ScreenUtil().setHeight(137.0),
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
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(29.0),
                              left: ScreenUtil().setWidth(8.0),
                              right: ScreenUtil().setWidth(14.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flower.name,
                                  style: GoogleFonts.nunito(
                                    fontSize: ScreenUtil().setSp(16.0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(8.0)),
                                Text(
                                  flower.description,
                                  maxLines: 3,
                                  style: GoogleFonts.nunito(
                                    fontSize: ScreenUtil().setSp(14.0),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newFlower = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const YourFlowerAddPage()),
          );

          if (newFlower != null) {
            Provider.of<FlowerNotifier>(context, listen: false).addFlower(newFlower);
            _saveFlowers(context);
          }
        },
        backgroundColor: const Color.fromRGBO(210, 59, 106, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
        ),
        mini: false,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _saveFlowers(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> flowerList = Provider.of<FlowerNotifier>(context, listen: false)
        .flowers
        .map((flower) => flower.toJsonString())
        .toList();
    prefs.setStringList('flowers', flowerList);
  }
}
