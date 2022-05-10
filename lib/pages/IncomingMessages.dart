import 'package:flutter/material.dart';
import 'package:for_tests/platform_channel.dart';
import 'package:permission_handler/permission_handler.dart';

class IncomingMessages extends StatefulWidget {
  IncomingMessages({Key? key}) : super(key: key);

  @override
  State<IncomingMessages> createState() => _IncomingMessagesState();
}

class _IncomingMessagesState extends State<IncomingMessages> {
  String sms = 'No sms';

  String message = "";

  @override
  void initState() {
    super.initState();
    getPermission().then((value) {
      if (value) {
        PlatformChannel().smsStream().listen((event) {
          sms = event;
          setState(() {});
        });
      }
    });

    getMessage();
  }

  getMessage() {
    const str = "the quick brown fox jumps over the lazy dog";
    const start = "quick";
    const end = "over";

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);

    setState(() {
      message = str.substring(startIndex + start.length, endIndex);
    });
  }

  Future<bool> getPermission() async {
    if (await Permission.sms.status == PermissionStatus.granted) {
      return true;
    } else {
      if (await Permission.sms.request() == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Instantly SMS'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Incoming message Is: ',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(sms),
            const SizedBox(
              height: 20,
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
