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

  late String url;
  bool isLoading = true;
  final _key = UniqueKey();

  UrlView(String title, String url) {
    this.url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('webview flutter plus'),
      ),
      body: Stack(
        children: [
          // Text("Height of WebviewPlus: $_height",
          //     style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: WebViewPlus(
              key: _key,
              serverPort: 5353,
              javascriptChannels: null,
              initialUrl:
                  'http://192.168.0.198:8000/nokandaService/institutions/SKDL2pgPj2YPGHVcgIlc/events',
              // onWebViewCreated: (controller) {
              //   _controller = controller;
              // },

              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://checkoutwave.com')) {
                  print('blocking navigation to $request}');
                  setState(() {
                    isLoading = false;
                  });

                  return NavigationDecision.prevent;
                }
                setState(() {
                  isLoading = true;
                });
                return NavigationDecision.navigate;
              },
              onPageFinished: (url) async {
                print(url);
                if (url.contains("tel")) {
                  print("contains tel");
                  print("url is" + url);
                  String launchThis = url.replaceAll("#", "%23");
                  // print("launch is " + launchThis);

                  // Replace * with %2A and # with %23:

                  String code = "tel:*255%23";

                  // await telephony.dialPhoneNumber("*182*2*1*1*1*100#");

                  if (!await launch(launchThis)) throw 'Could not launch $code';
                }
                setState(() {
                  isLoading = false;
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),

          isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Container(),
        ],
      ),
    );
  }
}
