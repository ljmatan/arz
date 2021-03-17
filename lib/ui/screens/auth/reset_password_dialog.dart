import 'package:arz/logic/auth/auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordDialogState();
  }
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  bool _processing = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16, 0, 16, MediaQuery.of(context).viewInsets.bottom),
        child: _processing
            ? CircularProgressIndicator()
            : Material(
                elevation: 16,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 18),
                        child: Text(
                          'Please enter your email address',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          autofocus: true,
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                          validator: (email) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email!))
                              return 'Please check your email';
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                onPrimary: Theme.of(context).primaryColor,
                                primary: Colors.transparent,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _processing = true);
                                  final bool? success =
                                      await AuthAPI.sendPasswordResetEmail(
                                          _emailController.text);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(success != null && success
                                          ? 'Reset password link had been sent to your email'
                                          : 'Error. Please try again later')));
                                }
                              },
                              child: Text('CONFIRM'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                onPrimary: Colors.white,
                                primary: Theme.of(context).primaryColor,
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text('CANCEL'),
                            ),
                          ],
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
    super.dispose();
  }
}
