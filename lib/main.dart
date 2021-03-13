import 'package:arz/ui/view/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: const Color(0xff4c87b1),
    ),
  );

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff4c87b1),
        dividerColor: const Color(0xff4c87b1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleSpacing: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xff4c87b1),
        ),
      ),
      home: MainView(),
    );
  }
}
