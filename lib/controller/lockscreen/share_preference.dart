import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreenController extends GetxController {
  bool _boolvalue = false;
  String _stringvale = "";
  bool get getValuebool => _boolvalue;
  String get getValueString => _stringvale;

  mainFunction() async {
    final sharedpreferences = await SharedPreferences.getInstance();
    final boolvalue = await sharedpreferences.getBool("boollocked");
    log(boolvalue.toString());
    final lockValue = await sharedpreferences.getString("stringlokked");
    _boolvalue = boolvalue!;
    _stringvale = lockValue == null ? "" : lockValue;
    update();
  }

  Future<void> localAuth(BuildContext context) async {
  final localAuth = LocalAuthentication();
  final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate');
  if (didAuthenticate) {
    Navigator.pop(context);
  }
}
}
