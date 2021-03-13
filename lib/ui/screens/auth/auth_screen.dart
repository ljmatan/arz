import 'package:arz/ui/screens/auth/login_page.dart';
import 'package:arz/ui/screens/auth/register_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _pagecontroller = PageController();

  void _goToPage(int page) => _pagecontroller.animateToPage(page,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pagecontroller,
        scrollDirection: Axis.vertical,
        children: [
          LoginPage(goToPage: _goToPage),
          RegisterPage(goToPage: _goToPage),
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
