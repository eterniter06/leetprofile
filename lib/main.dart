import 'package:flutter/material.dart';
import 'package:ui_elements/components/database/database.dart';
import 'pages/userlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init();
  runApp(const MainApp());
}
