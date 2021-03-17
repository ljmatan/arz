import 'package:arz/logic/auth/auth.dart';
import 'package:arz/ui/screens/home/home_screen.dart';
import 'package:arz/ui/view/bloc/main_view_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function(int)? goToPage;

  RegisterPage({@required this.goToPage});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    18, MediaQuery.of(context).padding.top, 18, 0),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14, top: 4),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          controller: _confirmPasswordController,
                          decoration:
                              InputDecoration(labelText: 'Repeat Password'),
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
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    final Function(int)? goToPage =
                                        widget.goToPage;
                                    if (goToPage != null) goToPage(0);
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
                                      width: MediaQuery.of(context).size.width,
                                      height: 56,
                                      child: Center(
                                        child: Text(
                                          'REGISTER',
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
                                    if (_passwordController.text ==
                                            _confirmPasswordController.text &&
                                        _emailController.text.isNotEmpty &&
                                        _passwordController.text.isNotEmpty &&
                                        _confirmPasswordController
                                            .text.isNotEmpty) {
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
                                          await AuthAPI.createUsingEmail(
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
                                    } else
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please check your input')));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
