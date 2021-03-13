import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  final GlobalKey _webViewKey = GlobalKey();

  InAppWebViewController? _webViewController;
  InAppWebViewGroupOptions _webViewOptions = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController _pullToRefreshController;

  String _url = "https://www.google.com/";

  int _progress = 0;

  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (io.Platform.isAndroid)
          _webViewController?.reload();
        else if (io.Platform.isIOS) {
          _webViewController?.loadUrl(
            urlRequest: URLRequest(
              url: await _webViewController?.getUrl(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'WebView Example',
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: InAppWebView(
        key: _webViewKey,
        initialOptions: _webViewOptions,
        pullToRefreshController: _pullToRefreshController,
        initialUrlRequest: URLRequest(url: Uri.parse(_url)),
        onProgressChanged: (controller, currentProgress) {
          _progress = currentProgress;
          print(currentProgress);
        },
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
