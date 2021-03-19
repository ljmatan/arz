import 'dart:io' as io;

import 'package:arz/logic/auth/auth.dart';
import 'package:arz/shared/custom_icons.dart';
import 'package:arz/ui/screens/auth/reset_password_dialog.dart';
import 'package:arz/ui/screens/home/home_screen.dart';
import 'package:arz/ui/view/bloc/main_view_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function(int)? goToPage;

  LoginPage({@required this.goToPage});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: kElevationToShadow[2],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ARZ',
                            style: TextStyle(
                              fontFamily: 'MuseoModerno',
                              fontWeight: FontWeight.w100,
                              color: Theme.of(context).primaryColor,
                              fontSize: 64,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 12),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 56,
                                      child: Center(
                                        child: Text(
                                          'REGISTER',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      final Function(int)? goToPage =
                                          widget.goToPage;
                                      if (goToPage != null) goToPage(1);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(28),
                                        boxShadow: kElevationToShadow[2],
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 56,
                                        child: Center(
                                          child: Text(
                                            'LOGIN',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      showDialog(
                                        context: context,
                                        barrierColor: Colors.white70,
                                        barrierDismissible: false,
                                        builder: (context) => WillPopScope(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          onWillPop: () async => false,
                                        ),
                                      );
                                      final UserCredential? userCredential =
                                          await AuthAPI.loginEmail(
                                              _emailController.text,
                                              _passwordController.text);
                                      Navigator.pop(context);
                                      if (userCredential == null)
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Login unsuccessful. Please check your info.')));
                                      else
                                        MainViewController.change(HomeScreen());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 26, bottom: 14),
                            child: Text(
                              'or',
                              style: const TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 44,
                                icon: Icon(
                                  CustomIcons.facebook,
                                  color: Colors.black45,
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.white70,
                                    barrierDismissible: false,
                                    builder: (context) => WillPopScope(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                      onWillPop: () async => false,
                                    ),
                                  );
                                  late bool response;
                                  try {
                                    response = await AuthAPI.fbLogin();
                                  } catch (e) {
                                    response = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('$e')));
                                  }
                                  Navigator.pop(context);
                                  if (response == true)
                                    // If login is successful
                                    MainViewController.change(HomeScreen());
                                },
                              ),
                              if (io.Platform.isIOS) const SizedBox(width: 12),
                              if (io.Platform.isIOS)
                                IconButton(
                                  iconSize: 44,
                                  icon: Icon(
                                    CustomIcons.apple,
                                    color: Colors.black45,
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierColor: Colors.white70,
                                      barrierDismissible: false,
                                      builder: (context) => WillPopScope(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                        onWillPop: () async => false,
                                      ),
                                    );
                                    bool? response;
                                    try {
                                      response = await AuthAPI.appleLogin();
                                    } catch (e) {
                                      response = false;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text('$e')));
                                    }
                                    Navigator.pop(context);
                                    if (response == true)
                                      MainViewController.change(HomeScreen());
                                  },
                                ),
                              const SizedBox(width: 12),
                              IconButton(
                                iconSize: 44,
                                icon: Icon(
                                  CustomIcons.google,
                                  color: Colors.black45,
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.white70,
                                    barrierDismissible: false,
                                    builder: (context) => WillPopScope(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                      onWillPop: () async => false,
                                    ),
                                  );
                                  bool? response;
                                  try {
                                    response = await AuthAPI.googleLogin();
                                  } catch (e) {
                                    response = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('$e')));
                                  }
                                  Navigator.pop(context);
                                  if (response == true)
                                    MainViewController.change(HomeScreen());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  onTap: () => showDialog(
                    context: context,
                    barrierColor: Colors.white70,
                    builder: (context) => ResetPasswordDialog(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
