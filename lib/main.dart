import 'package:flutter/material.dart';

import 'core.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    setup(); // Initialize dependencies

  runApp(const MyApp());
}
