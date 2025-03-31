import 'package:flutter/material.dart';
import 'package:flutter_hive/pages/home_page.dart';
import 'package:hive_local_storage/hive_local_storage.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("testBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
