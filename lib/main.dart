import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_mangement_application/Model/category.dart';
import 'package:flutter_money_mangement_application/Model/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Screens/Splash_screen/splash_screen.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<Category>('categories');
  await Hive.openBox('storage');
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff26384f)),
          // scaffoldBackgroundColor: Colors.black
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
