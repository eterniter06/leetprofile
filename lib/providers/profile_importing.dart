import 'package:flutter/material.dart';

class ProfileImportStatus extends ChangeNotifier {
  bool _isProfileBeingImported;

  bool get isProfileBeingImported => _isProfileBeingImported;

  set isProfileBeingImported(bool value) {
    _isProfileBeingImported = value;
    notifyListeners();
  }

  ProfileImportStatus({bool isProfileBeingImported = false})
      : _isProfileBeingImported = isProfileBeingImported;
}
