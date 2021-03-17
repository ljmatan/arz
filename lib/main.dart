import 'package:arz/logic/cache/prefs.dart';
import 'package:arz/shared/overscroll_effect.dart';
import 'package:arz/ui/view/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: const Color(0xff4c87b1),
    ),
  );

  await Firebase.initializeApp();

  await Prefs.init();

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
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xff4c87b1),
          behavior: SnackBarBehavior.floating,
          elevation: 2,
        ),
      ),
      builder: (context, child) => ScrollConfiguration(
        behavior: OverscrollRemovedBehavior(),
        child: child!,
      ),
      home: MainView(),
    );
  }
}
