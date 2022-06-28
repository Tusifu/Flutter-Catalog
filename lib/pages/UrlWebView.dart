import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:telephony/telephony.dart';
import 'dart:io' show Platform;

class UrlView extends StatefulWidget {
  UrlView({Key? key}) : super(key: key);

  @override
  State<UrlView> createState() => _UrlViewState();
}

class _UrlViewState extends State<UrlView> {
  @override
  void initState() {
    super.initState();
  }

  final telephony = Telephony.instance;

  bool isLoading = true;
  final _key = UniqueKey();

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
                  'http://192.168.0.198:8000/nokandaService/institutions/SKDL2pgPj2YPGHVcgIlc/events/0788862917',
              // onWebViewCreated: (controller) {
              //   _controller = controller;
              // },

              navigationDelegate: (NavigationRequest request) async {
                if (request.url
                    .startsWith('https://checkout.flutterwave.com')) {
                  setState(() {
                    isLoading = false;
                  });
                  print('here');
                  return NavigationDecision.navigate;
                }
                if (request.url.startsWith('tel')) {
                  print('show url ${request.url}');
                  String url = request.url.split('tel:')[1];

                  if (Platform.isAndroid) {
                    await FlutterPhoneDirectCaller.callNumber(url);
                  } else if (Platform.isIOS) {
                    // on ios final # is considered as 23. so we remove last
                    // two characters and replace with # and make a call

                    String s = request.url.split('tel:')[1];
                    String url = s.substring(0, s.length - 2) + "#";

                    await FlutterPhoneDirectCaller.callNumber(url);
                  }

                  return NavigationDecision.prevent;
                }
                setState(() {
                  isLoading = true;
                });
                return NavigationDecision.navigate;
              },
              onPageFinished: (url) async {
                // String code = url.split(":")[1];
                // print(code);
                // String codeToSend = Functions()
                //     .computeCodeToSend(code, '0781715054', '0781715054');
                // const platform = const MethodChannel('com.kene.for_tests');

                // try {
                //   var res = await platform.invokeMethod(
                //       "moMoDialNumber", {"code": codeToSend, "motive": 1});
                //   print(res);
                // } on PlatformException catch (e) {
                //   print("error check balance is $e");
                // }

                print(url);
                if (url.contains("tel")) {
                  print("contains tel");
                  print("url is " + url);
                  String launchThis = url.replaceAll("#", "%23");
                  // print("launch is " + launchThis);

                  // Replace * with %2A and # with %23:

                  String code = "tel:*255%23";

                  // TELEPHONY CALLER
                  // await telephony.dialPhoneNumber("*182*2*1*1*1*100#");

                  // if (Platform.isAndroid) {
                  //   await FlutterPhoneDirectCaller.callNumber(url);

                  //   Navigator.pop(context);
                  // } else if (Platform.isIOS) {
                  //   //URL LAUNCHER CALLER
                  //   if (await canLaunch(url)) {
                  //     await launch(url);
                  //   } else {
                  //     throw 'Could not launch $url';
                  //   }
                  // }
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
