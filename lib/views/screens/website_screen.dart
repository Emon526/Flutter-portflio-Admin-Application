import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants.dart';

class WebsiteView extends StatelessWidget {
  const WebsiteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   backgroundColor: darkColor,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: const Text('Website View'),
      // ),
      body: SafeArea(
        child: WebView(
          allowsInlineMediaPlayback: true,
          backgroundColor: darkColor,
          zoomEnabled: false,
          initialUrl: 'https://google.com',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
