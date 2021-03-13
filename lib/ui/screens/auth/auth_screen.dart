import 'package:arz/ui/screens/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pagecontroller,
        children: [
          LoginPage(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }
}
