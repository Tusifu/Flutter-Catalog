import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'dart:async';

import 'package:telephony/telephony.dart';

class MobileNumberPackage extends StatefulWidget {
  MobileNumberPackage({Key? key}) : super(key: key);

  @override
  State<MobileNumberPackage> createState() => _MobileNumberPackageState();
}

class _MobileNumberPackageState extends State<MobileNumberPackage> {
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  final telephony = Telephony.instance;
  String _message = "";
  String _address = "";

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
        onNewMessage: onMessage,
      );
    }
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
      _address = message.address ?? '';
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
    });
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }

  String splitNumber(String? number) {
    return number!.split("+25")[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Number'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text('Running on: $_mobileNumber\n'),
            fillCards(),
            const SizedBox(height: 10),
            // Text(
            // "Firt Number:   ${_simCard[0].number!.split('+25')[1] ?? ''} \n Second number: ${_simCard[1].number!.split('+25')[1] ?? ''}"),
            const SizedBox(height: 10),
            // Text("the message is: $_message"),
            Text("the message address is: $_address"),
          ],
        ),
      ),
    );
  }
}
