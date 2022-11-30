import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_money_mangement_application/constents/app_theme.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLockScreen extends StatelessWidget {
  const ScreenLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blueColors,
      appBar: AppBar(
        title: const Text("Passcode"),
      ),
      body: Column(children: [
        ListTile(
          onTap: () async {
            final sharedpreferences = await SharedPreferences.getInstance();
            final boolvalue =
                await sharedpreferences.setBool("boollocked", false);
            final lockValue = await sharedpreferences.getString("stringlokked");

            await screenLock(
              context: context,
              correctString: lockValue!,
              canCancel: false,
            );
            // await sharedpreferences.remove("stringlokked");
            await sharedpreferences.remove("stringlokked");

            Navigator.of(context).pop();
          },
          title: const Text("Turn off Passcode"),
        ),
        ListTile(
          onTap: () async {
            final sharedpreferences = await SharedPreferences.getInstance();
            final boolvalue =
                await sharedpreferences.setBool("boollocked", false);
            final lockValue = await sharedpreferences.getString("stringlokked");

            await screenLock(
              context: context,
              correctString: lockValue!,
              canCancel: false,
            );
            await sharedpreferences.remove("stringlokked");
            screenLockCreate(
                context: context,
                onConfirmed: (value) async {
                  log(value);
                  final stringer =
                      await sharedpreferences.setString("stringlokked", value);
                  final boollocked =
                      await sharedpreferences.setBool("boollocked", true);
                  // setState(() {
                  //   isLocked = boollocked;
                  // });
                  // log("${isLocked.toString() + stringer.toString()}");
                  Navigator.of(context).pop();
                });
          },
          title: const Text("Change Passcode"),
        ),
        // ListTile(
        //   onTap: () {},
        //   title: Text("Turn off Passcode"),
        // ),
      ]),
    );
  }
}
