import 'package:client_manager/provider/idCollector.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:client_manager/function/mainFunction.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'container/electric/electricInfo/model/graphData.dart';
import 'container/electric/electricInfo/model/usageData.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IdCollector(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsageData(0, 0),
        ),
        ChangeNotifierProvider(
          create: (_) => GraphData(0, [FlSpot(0.0, 0.0)]),
        ),
      ],
      child: MyApp(),
    ),
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
