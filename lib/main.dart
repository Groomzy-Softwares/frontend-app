import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:groomzy/android/main.dart';
import 'package:groomzy/ios/main.dart';
import 'package:groomzy/web/main.dart';

void main() {
  runApp(MyApp());
}

Widget getAppAccordingToCurrentPlatform() {
  if (Platform.isIOS) {
    return IOSApp();
  } else if (kIsWeb) {
    return WebApp();
  }

  return AndroidApp();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return getAppAccordingToCurrentPlatform();
  }
}
