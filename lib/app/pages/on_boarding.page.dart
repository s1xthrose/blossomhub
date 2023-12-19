import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:blossomhub/app/pages/home.page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          ScreenUtil.init(context, designSize: const Size(393, 852));

          return Scaffold(
            backgroundColor: const Color(0xFFEBFFF0),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: const [
                        OnboardingSlide(
                          title: 'Welcome to BlossomHub',
                          description: 'Your personal helper with flowers care',
                          currentPage: 0,
                        ),
                        OnboardingSlide(
                          image: 'assets/on_boarding/first_pic.png',
                          title: 'Waterlog',
                          description: 'Control watering of flowers\nwith our Waterlog section',
                          currentPage: 1,
                        ),
                        OnboardingSlide(
                          image: 'assets/on_boarding/second_pic.png',
                          title: 'Replanting Schedule',
                          description: 'You don’t forget to replant\nyour flower with our schedule',
                          currentPage: 2,
                        ),
                        OnboardingSlide(
                          image: 'assets/on_boarding/third_pic.png',
                          title: 'Something more',
                          description: 'Just go inside and use\nall features to make life easier',
                          currentPage: 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < 3) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(ScreenUtil().setWidth(229), ScreenUtil().setHeight(45)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(100)),
                      ),
                      backgroundColor: const Color(0xFFD23B6A),
                    ),
                    child: Text(
                      _currentPage < 3 ? 'Continue' : 'Get Started',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontFamily: 'Nunito',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OnboardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int currentPage;

  const OnboardingSlide({
    Key? key,
    this.image = '',
    required this.title,
    required this.description,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(360),
      height: ScreenUtil().setHeight(480),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: currentPage == 0 ? 0 : 90.h),
      decoration: BoxDecoration(
        color: currentPage == 0 ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(currentPage == 0 ? 0 : 12.0),
        boxShadow: currentPage == 0
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(currentPage == 0 ? 0 : 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image.isNotEmpty)
              Image.asset(
                image,
                width: ScreenUtil().setWidth(360),
                height: ScreenUtil().setHeight(354),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            SizedBox(height: 9.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: currentPage == 0 ? 70 : 0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontWeight: title == 'Welcome to BlossomHub' ? FontWeight.w800 : FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: title == 'Welcome to BlossomHub' ? 36 : 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 9.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: currentPage == 0 ? 62 : 0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontWeight: description == 'Your personal helper with flowers care' ? FontWeight.w500 : FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: description == 'Your personal helper with flowers care' ? 20 : 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}




