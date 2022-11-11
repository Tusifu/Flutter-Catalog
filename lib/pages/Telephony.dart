import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint(message.toString());
}

class TelephonyPage extends StatefulWidget {
  @override
  _TelephonyPageState createState() => _TelephonyPageState();
}

class _TelephonyPageState extends State<TelephonyPage> {
  String _message = "";
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
        onNewMessage: onMessage,
        onBackgroundMessage: onBackgroundMessage,
      );
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telephony'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // Logger.root.level = Level.ALL;
                // Logger.root.onRecord.listen((record) {
                //   debugPrint(
                //       '${record.level.name}: ${record.time}: ${record.message}');
                // });
                await telephony.sendSms(
                  to: "0781715054",
                  message: "TEST SENDING SMS!",
                );
              },
              child: const Text('Send SMS '),
            ),
          ),
          // Center(child: Text("Latest received SMS: $_message")),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () async {
              List<SignalStrength> strenghts = await telephony.signalStrengths;
              print(strenghts);
            },
            child: const Text(
              'Measure Strength',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () async {
              await telephony.openDialer("123413453");
            },
            child: const Text('Open Dialer'),
          ),
        ],
      ),
    );
  }
}
