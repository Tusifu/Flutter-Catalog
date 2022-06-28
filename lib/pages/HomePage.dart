import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Catalog'),
      ),
      body: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                const number = '*182#'; //set the number here
                bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
              },
              child: const Text('Direct Call'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                String code = "tel://07811111111";
                if (!await launch(code)) throw 'Could not launch $code';
              },
              child: const Text('Indirect Call'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/dialPad');
              },
              child: const Text('Dial Pad'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/messageReader');
              },
              child: const Text('Message Reader'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/htmlFlutter');
              },
              child: const Text('HTML Flutter'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/incomingMessage');
              },
              child: const Text('Incoming Message'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/urlwebview');
              },
              child: const Text('Url WEB View'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/mobileNumber');
              },
              child: const Text('Mobile Number'),
            ),
          ),
        ],
      ),
    );
  }
}
