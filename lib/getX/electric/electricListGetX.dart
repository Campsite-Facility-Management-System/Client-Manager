import 'package:client_manager/function/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ElectricInfoGetX extends GetxController {
  final token = new FlutterSecureStorage();
  // var campNameList = List<String>().obs;
  // var campIdList = List<String>().obs;
  List<String> campNameList = [];
  List<String> campIdList = [];
  var selectedCampId = ''.obs;
  var selectedCampName = ''.obs;
  var detailData = List<dynamic>().obs;

  setSelectedCampId(campId) async {
    selectedCampId.value = campId;
    await apiElectricCategoryList();
  }

  setSelectedCampName(campName) {
    selectedCampName.value = campName;
  }

  apiCampInfo() async {
    var url = Env.url + '/api/campsite/manager/info';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value.toString());

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    });

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    for (var i = 0; i < data.length; i++) {
      campNameList.add(data[i]['name'].toString());
      campIdList.add(data[i]['id'].toString());
    }

    setSelectedCampId(campIdList[0]);
    setSelectedCampName(campNameList[0]);
  }

  apiElectricCategoryList() async {
    var url = Env.url + '/api/device/manager/energy/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': selectedCampId.toString(),
    });

    detailData.value = jsonDecode(utf8.decode(response.bodyBytes));

    print('data: ' + detailData.toString());
  }

  apichangeStatus(isSwitched, deviceId) async {
    // tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/controll';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    int status;

    if (isSwitched == true) {
      status = 1;
    } else {
      status = 0;
    }
    print('deviceId: ' + deviceId.toString());

    print('to: ' + status.toString());

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
      'command': status.toString(),
    });

    print(response.statusCode.toString());

    Future.delayed(Duration(milliseconds: 200), () async {
      await apiElectricCategoryList();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiCampInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
