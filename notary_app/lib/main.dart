import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      title: 'Expense App',
      home: LoginScreen(),
    );
  }
}
