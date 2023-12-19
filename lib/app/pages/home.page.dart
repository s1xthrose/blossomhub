import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'control.page.dart';
import 'journal.page.dart';
import 'settings.page.dart';
import 'yourflow.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Widget _buildTabItem(int index, IconData icon, String label) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _tabController.index = index;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _tabController.index == index
                ? const Color.fromRGBO(210, 59, 106, 0.7)
                : const Color.fromRGBO(235, 255, 240, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
            ),
            elevation: 0,
            padding: EdgeInsets.zero,
          ),
          child: Icon(
            icon,
            color: _tabController.index == index ? Colors.black : Colors.black,
            size: ScreenUtil().setSp(24),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(4)),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: ScreenUtil().setSp(12),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: _tabController.index == index
                ? const Color.fromRGBO(210, 59, 106, 0.7)
                : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          WelcomeWidget(),
          ControlPage(),
          JournalPage(),
          SettingsPage(),
        ],
      ),
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      extendBody: true,
      persistentFooterButtons: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(0, Icons.home, 'Home'),
              _buildTabItem(1, Icons.eco, 'Control'),
              _buildTabItem(2, Icons.list_alt, 'Journal'),
              _buildTabItem(3, Icons.settings, 'Settings'),
            ],
          ),
        ),
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(16),
        ScreenUtil().setWidth(65),
        0,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: GoogleFonts.nunito(
              fontSize: ScreenUtil().setSp(17),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontFeatures: [
                const FontFeature.enable('clig'),
                const FontFeature.enable('liga'),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(41)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your flowers',
                style: GoogleFonts.nunito(
                  fontSize: ScreenUtil().setSp(18),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const YourFlowPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.chevron_right,
                    size: ScreenUtil().setSp(24),
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(16)),
          SizedBox(
            height: ScreenUtil().setHeight(205),
            child: Consumer<FlowerNotifier>(
              builder: (context, flowerNotifier, child) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(4)),
                  scrollDirection: Axis.horizontal,
                  itemCount: flowerNotifier.flowers.length,
                  itemBuilder: (context, index) {
                    final flower = flowerNotifier.flowers[index];
                    return Container(
                      width: ScreenUtil().setWidth(139),
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
                            child: FutureBuilder(
                              future: _getResizedImage(flower.imageUrl),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return Image.memory(
                                    snapshot.data as Uint8List,
                                    fit: BoxFit.cover,
                                    width: ScreenUtil().setWidth(139),
                                    height: ScreenUtil().setHeight(137),
                                  );
                                } else {
                                  return Container(
                                    width: ScreenUtil().setWidth(139),
                                    height: ScreenUtil().setHeight(137),
                                    color: Colors.grey,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(6)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                            child: Text(
                              flower.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                          //SizedBox(height: ScreenUtil().setHeight(3)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                            child: Text(
                              flower.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                color: const Color.fromRGBO(77, 68, 68, 1),
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Future<Uint8List> _getResizedImage(String imageUrl) async {
    if (imageUrl.isNotEmpty && File(imageUrl).existsSync()) {
      File imageFile = File(imageUrl);
      return await imageFile.readAsBytes();
    }

    ByteData byteData = await rootBundle.load('assets/placeholder_image.png');
    return byteData.buffer.asUint8List();
  }
}
