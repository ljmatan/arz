import 'package:arz/ui/screens/auth/auth_screen.dart';
import 'package:arz/ui/view/bloc/main_view_controller.dart';
import 'package:arz/ui/webview/webview_screen.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    MainViewController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: MainViewController.stream,
        initialData: AuthScreen(),
        builder: (context, AsyncSnapshot<Widget> view) =>
            view.data ?? const SizedBox(),
      ),
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                'WebView Example',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => WebViewScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    MainViewController.dispose();
    super.dispose();
  }
}
