import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_mangement_application/Screens/Settings/edit_profile.dart';
import 'package:flutter_money_mangement_application/Screens/home/home_drawer.dart';
import 'package:flutter_money_mangement_application/constents/app_theme.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/lockscreen/share_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final colorizeColors = [
    Colors.black,
    Colors.black,
    Colors.blue,
    AppTheme.appbarColor,
    Colors.transparent
  ];
  @override
  void initState() {
    /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);*/
    checkInited(context);
    _mainController.mainFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppTheme.blueColors,
      body: Column(children: [
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   color: Colors.grey.shade100,
        // ),
        // Image.asset('assets/images/spl_top.png'),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: Image.asset('assets/images/spl_bottom.png'),
        // ),
        // Align(
        //   child: Column(mainAxisSize: MainAxisSize.min, children: [
        //     Container(
        //       width: 80,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20),
        //           boxShadow: const [
        //             BoxShadow(
        //               offset: Offset(2, 5),
        //               blurRadius: 10.0,
        //               color: Color.fromARGB(100, 0, 0, 0),
        //             )
        //           ]),
        //       clipBehavior: Clip.antiAlias,
        //       child: Lottie.asset(
        //         "assets/images/55607-flying-wallet-money.json",
        //       ),
        //     ),
        //     const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Center(
          child: Lottie.asset(
            "assets/images/wallet.json",
          ),
        ),
        Center(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'Money Manager',
                textStyle: GoogleFonts.righteous(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        offset: Offset(2, 5),
                        blurRadius: 10.0,
                        color: Color.fromARGB(100, 0, 0, 0),
                      ),
                    ]),
                speed: const Duration(milliseconds: 600),
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: false,
          ),
        ),
      ]),
    );
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);*/
    super.dispose();
  }

 

  final _mainController = Get.put(LockScreenController());

  checkInited(context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isInited = prefs.getBool('isInited') ?? false;
    Timer(const Duration(seconds: 3), () async {
      _mainController.getValuebool == true
          ? await screenLock(
              context: context,
              correctString: _mainController.getValueString,
              canCancel: false,
              
            )
          : "";

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isInited
              ? const HomeDrawer()
              : const EditProfile(
                  isFromInit: true,
                ),
        ),
      );
    });
  }
}
