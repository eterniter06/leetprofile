import 'package:flutter/material.dart';
import 'package:ui_elements/database.dart';
import 'homepage/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init();
  runApp(const MainApp());
}
