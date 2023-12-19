import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/pages/wateringschedule.page.dart';
import 'app/pages/yourflow.page.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsController),
        ChangeNotifierProvider<FlowerNotifier>(create: (_) => FlowerNotifier()),
        ChangeNotifierProvider(create: (_) => WateringProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
