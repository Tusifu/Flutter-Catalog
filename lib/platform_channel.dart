import 'package:flutter/services.dart';

class PlatformChannel {
  static const _channel = EventChannel("com.example.app/smsStream");

  Stream smsStream() async* {
    yield* _channel.receiveBroadcastStream();
  }
  // static const _channel = MethodChannel("com.example.app/sms");

  // Future<String> sms() async {
  //   try {
  //     final result = await _channel.invokeMethod("receive_sms");
  //     return result as String;
  //   } catch (e) {
  //     log(e.toString());
  //     return "";
  //   }
  // }
}
