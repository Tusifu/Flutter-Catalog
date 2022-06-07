import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart';

class HtmlFlutterMainPage extends StatefulWidget {
  const HtmlFlutterMainPage({Key? key}) : super(key: key);

  @override
  _HtmlFlutterMainPageState createState() => _HtmlFlutterMainPageState();
}

class _HtmlFlutterMainPageState extends State<HtmlFlutterMainPage> {
  final telephony = Telephony.instance;
  WebViewPlusController? _controller;
  double _height = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('webview_flutter_plus Plugin'),
      ),
      body: ListView(
        children: [
          // Text("Height of WebviewPlus: $_height",
          //     style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: WebViewPlus(
              serverPort: 5353,
              javascriptChannels: null,
              initialUrl: 'assets/index.html',
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (url) async {
                print(url);
                if (url.contains("tel")) {
                  // print("contains tel");

                  // Replace * with %2A and # with %23:

                  // String code = "tel:*255%23";
                  Navigator.of(context).pop();
                  // String code = "*182#";
                  String code = "tel:*182#";
                  // await telephony.openDialer(code);
                  // bool res = (await FlutterPhoneDirectCaller.callNumber(code))!;
                  if (!await launch(code)) throw 'Could not launch $code';
                }
                _controller?.getHeight().then((double height) {
                  setState(() {
                    _height = height;
                  });
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
