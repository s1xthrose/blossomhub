import 'package:flutter/material.dart';
import 'package:blossomhub/app/pages/splash.page.dart';

import '../app/pages/on_boarding.page.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      routes: {
        '/on_boarding': (context) => const OnboardingPage(),
      },
    );
  }
}
