import 'package:flutter/material.dart';
import 'package:client_manager/function/mainFunction.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '모닥모닥',
      debugShowCheckedModeBanner: false,
      home: MainFunction(0),
    );
  }
}
