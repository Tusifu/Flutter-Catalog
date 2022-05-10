import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsReader extends StatefulWidget {
  SmsReader({Key? key}) : super(key: key);

  @override
  State<SmsReader> createState() => _SmsReaderState();
}

class _SmsReaderState extends State<SmsReader> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_sms_inbox package'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _messages.length,
          itemBuilder: (BuildContext context, int i) {
            var message = _messages[i];
            var messageDisplay = message.body;

            // Pattern p = Pattern.compile("(Car|Truck|Van):\\s*(\\w+)");

            return ListTile(
              title: Text('${message.sender} [${message.date}]'),
              subtitle: Text('${message.body}'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var permission = await Permission.sms.status;
          if (permission.isGranted) {
            final messages = await _query.querySms(
              kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
              address: '+250783382866',
              count: 10,
              start: 0,
            );
            debugPrint("the length of the message ${messages.length}");

            setState(() => _messages = messages);
          } else {
            await Permission.sms.request();
          }
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
