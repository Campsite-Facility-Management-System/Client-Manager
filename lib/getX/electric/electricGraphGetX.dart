import 'dart:async';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
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

      if (do_loop.value) {
        apiUsageData();
        apiGraph();
        update();
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

    var data = utf8.decode(response.bodyBytes);
    print(data);
    usageData = jsonDecode(data) as Map;
    usage.value = usageData["usage"].toString();
    charge.value = usageData["charge"].toString();
  }

  apiDeviceState() async {
    var url = Env.url + '/api/device/manager/state';
    String value = await token.read(key: 'token');
    String headers = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'device_id': deviceId.toString(),
    });

    request.headers.addAll({'Authorization': headers});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var state = jsonDecode(data);

      if (state['state'] == '0') {
        isSwitched.value = false;
      } else {
        isSwitched.value = true;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  apichangeStatus(change) async {
    var url = Env.url + '/api/device/manager/controll';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    int status;

    if (change == true) {
      status = 1;
    } else {
      status = 0;
    }

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
      'command': status.toString(),
    });

    isSwitched.value = change;
  }

  apiGraph() async {
    // tokenFunction.tokenCheck();

    print('deviceId: ' + deviceId.toString());

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
    electricity.value = spotList;
    max.value = graphData['max'].toInt();

    update();
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
