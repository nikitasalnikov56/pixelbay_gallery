import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/domain/getit/app_getit.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  AppGetIt.setupGetIt();
  runApp(const App());
}
