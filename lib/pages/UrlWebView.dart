import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:telephony/telephony.dart';

class UrlView extends StatefulWidget {
  UrlView({Key? key}) : super(key: key);

  @override
  State<UrlView> createState() => _UrlViewState();
}

class _UrlViewState extends State<UrlView> {
  final telephony = Telephony.instance;
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
              initialUrl:
                  'https://tickets.nokanda.app/nokandaService/institutions/SKDL2pgPj2YPGHVcgIlc/events',
              // onWebViewCreated: (controller) {
              //   _controller = controller;
              // },
              onPageFinished: (url) async {
                print(url);
                if (url.contains("tel")) {
                  print("contains tel");
                  print("url is" + url);
                  String launchThis = url.replaceAll("#", "%23");
                  print("launch is " + launchThis);

                  // Replace * with %2A and # with %23:

                  String code = "tel:*255%23";

                  await telephony.openDialer("123413453");

                  // if (!await launch(launchThis)) throw 'Could not launch $code';
                }
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
