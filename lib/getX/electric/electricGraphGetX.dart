import 'dart:async';
import 'package:client_manager/function/env.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ElectricGraphGetX extends GetxController {
  final token = new FlutterSecureStorage();
  Map graphData = Map().obs;
  List<FlSpot> spotList = List<FlSpot>().obs;
  // List<int> leftTitle = List<int>().obs;
  var max = 0.obs;
  var electricity = [].obs;
  var deviceName = ''.obs;
  var uuid = ''.obs;
  var usage = ''.obs;
  var charge = ''.obs;
  var statusData = [].obs;
  var isSwitched = false.obs;
  Map<String, dynamic> usageData;
  // var campId;
  // var categoryId;
  var deviceId = ''.obs;
  var do_loop = false.obs;

  @override
  onClose() {
    super.onClose();
    do_loop.value = false;
  }

  loop() async {
    do_loop.value = true;
    await Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 5));
      apiUsageData();
      apiGraph();
      if (do_loop.value) {
        return true;
      } else {
        return false;
      }
    });
    // const duration = const Duration(seconds: 5);
    // new Timer.periodic(duration, (Timer t) => apiGraph());
    // new Timer.periodic(duration, (Timer t) => apiUsageData());
  }

  apiUsageData() async {
    // tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/energy/usage';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
    });

    print(deviceId);

    usageData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    usage.value = usageData["usage"].toString();
    charge.value = usageData["charge"].toString();
  }

  // apiDeviceStatus() async {
  //   // tokenFunction.tokenCheck(context);

  //   var url = Env.url + '/api/device/manager/list';
  //   String value = await token.read(key: 'token');
  //   String myToken = ("Bearer " + value);

  //   print('확인: ' + campId.toString());

  //   var response = await http.post(Uri.parse(url), headers: {
  //     'Authorization': myToken,
  //   }, body: {
  //     'campsite_id': campId.toString(),
  //     'category_id': categoryId.toString(),
  //   });

  //   statusData.value = jsonDecode(utf8.decode(response.bodyBytes));
  //   if (statusData.value[0]["state"] == 0) {
  //     isSwitched.value = false;
  //   } else if (statusData[0]["state"] == 1) {
  //     isSwitched.value = true;
  //   }

  //   deviceName.value = statusData[0]["name"].toString();
  //   uuid.value = statusData[0]["uuid"].toString();
  // }

  apichangeStatus(change) async {
    var url = Env.url + '/api/device/manager/controll';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    int status;

    if (change == true) {
      status = 0;
    } else {
      status = 1;
    }

    // print(status.toString());
    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
      'command': status.toString(),
    });
    print(response.statusCode);

    isSwitched.value = change;
  }

  apiGraph() async {
    // tokenFunction.tokenCheck();
    spotList.clear();

    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
    });
    var data = utf8.decode(response.bodyBytes);
    print("data: " + data.toString());
    graphData = jsonDecode(data) as Map;
    spotList = makeSpot();
    // print(spot.toString());
    // for (int i = 0; i < 5; i++) {
    //   leftTitle.add((graphData["max"] / 4 * i).round());
    // }

    max.value = graphData['max'].toInt();
    electricity.value = spotList;
  }

  List<FlSpot> makeSpot() {
    List<FlSpot> spotList = [];
    if (graphData == null) {
      for (int i = 0; i < 13; i++) spotList.add(FlSpot(i.toDouble(), 0.0));
      return spotList;
    }

    for (int i = 1; i < 13; i++) {
      spotList.add(FlSpot(
          i.toDouble(), graphData["electricity"][12 - i]["watt"].toDouble()));
    }
    return spotList;
  }
}
