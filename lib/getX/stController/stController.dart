import 'dart:convert';

import 'package:client_manager/function/env.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StController extends GetxController {
  final token = FlutterSecureStorage();
  var category;
  var goods;
  List<FlSpot> electric = List<FlSpot>().obs;
  var electricData;
  var max;

  apiStCategory() async {
    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {});
    var data = utf8.decode(response.bodyBytes);
    print("data: " + data.toString());

    update();
  }

  apiStGoods() async {
    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {});
    var data = utf8.decode(response.bodyBytes);
    print("data: " + data.toString());

    max.value = electricData['max'].toInt();

    update();
  }

  apiStElectric() async {
    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {});
    var data = utf8.decode(response.bodyBytes);
    print("data: " + data.toString());
    electricData = jsonDecode(data) as Map;
    electric = makeSpot();

    max.value = electricData['max'].toInt();

    update();
  }

  List<FlSpot> makeSpot() {
    List<FlSpot> spotList = [];
    if (electricData = null) {
      for (int i = 0; i < 10; i++) spotList.add(FlSpot(i.toDouble(), 0.0));
      return spotList;
    }

    for (var i = 0; i < 10; i++) {
      spotList
          .add(FlSpot(i.toDouble(), electricData[10 - i]["watt"].toDouble()));
    }
    return spotList;
  }
}
