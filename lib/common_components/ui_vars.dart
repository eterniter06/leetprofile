import 'package:flutter/material.dart';

class RootScaffoldKey {
  late GlobalKey<ScaffoldState> scaffoldkey;

  RootScaffoldKey._privateConstructor() {
    scaffoldkey = GlobalKey<ScaffoldState>();
  }

  static final RootScaffoldKey _instance =
      RootScaffoldKey._privateConstructor();

  factory RootScaffoldKey() {
    return _instance;
  }
}
