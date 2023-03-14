import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HivePage extends StatefulWidget {
  @override
  _HivePageState createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Storage'),
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
                var box = Hive.box('myBox');

                box.put('name', 'David');
              },
              child: const Text('Store Data To Hive'),
            ),
          ),
        ],
      ),
    );
  }
}
