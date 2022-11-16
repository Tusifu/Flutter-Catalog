import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService {
  static Future<void> initDynamicLink(BuildContext context) async {
    print('link initialized');
    FirebaseDynamicLinks.instance.onLink;
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    try {
      final Uri deepLink = data!.link;
      var toTel = deepLink.pathSegments.contains('toTelephony');
      if (toTel) {
        print('there path segments');
        // String? id = deepLink.queryParameters['id'];

        // TODO : Navigate to your pages accordingly here
        Navigator.of(context).pushNamed('/telephony');
      } else {
        print('there is no deep link');
      }
    } catch (e) {
      print('No deepLink found');
    }
  }
}
