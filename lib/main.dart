import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_tests/pages/DialPadPage.dart';
import 'package:for_tests/pages/HomePage.dart';
import 'package:for_tests/pages/HtmlContent.dart';
import 'package:for_tests/pages/IncomingMessages.dart';
import 'package:for_tests/pages/MessageReader.dart';
import 'package:for_tests/pages/MobileNumber.dart';
import 'package:for_tests/pages/Telephony.dart';
import 'package:for_tests/pages/urlWebView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

taskFunction(data) {
  // read shared
  print('task to be executed $data');
}

const task = 'simpleTask';
@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    if (taskName == 'simpleTask') {
      taskFunction(inputData);
    }
    //simpleTask will be emitted here.
    return Future.value(true);
  });
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  final prefs = await SharedPreferences.getInstance();
  // await prefs.setString('token', 'thisistoken');

  final String? token = prefs.getString('token');
  // print('this token from prefs $token');
  Workmanager().registerOneOffTask(
    Random().toString(),
    task,
    initialDelay: const Duration(
      seconds: 30,
    ),
    inputData: <String, dynamic>{
      'shared_data': token,
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: <String, WidgetBuilder>{
        '/dialPad': (BuildContext context) => DialPagePage(),
        '/messageReader': (BuildContext context) => SmsReader(),
        '/htmlFlutter': (BuildContext context) => const HtmlFlutterMainPage(),
        '/incomingMessage': (BuildContext context) => IncomingMessages(),
        '/urlwebview': (BuildContext context) => UrlView(),
        '/mobileNumber': (BuildContext context) => MobileNumberPackage(),
        '/telephony': (BuildContext context) => TelephonyPage(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return HomePage();
  }
}
