import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';

class DialPagePage extends StatefulWidget {
  DialPagePage({Key? key}) : super(key: key);

  @override
  State<DialPagePage> createState() => _DialPagePageState();
}

class _DialPagePageState extends State<DialPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: DialPad(
            enableDtmf: true,
            outputMask: "",
            backspaceButtonIconColor: Colors.red,
            makeCall: (number) {
              print(number);
            }),
      ),
    );
  }
}
