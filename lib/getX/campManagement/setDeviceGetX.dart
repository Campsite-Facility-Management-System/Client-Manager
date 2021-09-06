import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:client_manager/function/env.dart';
import 'package:client_manager/function/mainFunction.dart';
import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SetDeviceGetX extends GetxController {
  final token = FlutterSecureStorage();
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  BluetoothConnection connection;
  var password;
  var uuid;
  var wifiList = [];
  var selectedWifi = 0.obs;
  int count = 0;

  sendWifiData(password) async {
    print(wifiList[selectedWifi.value].toString() +
        ',' +
        password.toString() +
        '\r\n');
    connection.output.add(utf8.encode(wifiList[selectedWifi.value].toString() +
        ',' +
        password.toString() +
        '\r\n'));
    await connection.output.allSent;
  }

  upload(deviceName, categoryId, campsiteId) async {
    print('디바이스: ' + deviceName.toString());
    print('카테고리id: ' + categoryId.toString());
    print('캠프id: ' + campsiteId.toString());
    print('uuid: ' + uuid.toString());

    var url = Env.url + '/api/device/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': deviceName.toString(),
      'uuid': uuid.toString(),
      'category_id': categoryId.toString(),
      'campsite_id': campsiteId.toString(),
    });

    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase.toString());
    print(response.stream.bytesToString());

    if (response.statusCode == 200) {
      Get.offAll(MainFunction());
    } else if (response.statusCode == 401) {
      // print("error");
    }
  }

  receive(Uint8List data) {
    wifiList.clear();

    if (count == 0) {
      print('수신 데이터: ' + Utf8Decoder().convert(data));

      var tmp = Utf8Decoder().convert(data).split(',');
      for (int i = 0; i < tmp.length - 1; i++) {
        wifiList.add(tmp[i]);
      }
      print('와이파이 리스트: ' + wifiList.toString());
      print('선택된 리스트: ' + selectedWifi.toString());

      count++;
      update();
    } else if (count == 1) {
      var tmp = Utf8Decoder().convert(data).split(',');
      if (tmp[0] == '0') {
        print("error");
      } else {
        uuid = tmp[1];
        print(uuid);
      }
      count = 0;
      update();
      connection.close();
      Get.offAll(AddDeviceScreen());
    }
  }

  connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('커넥트 결과: Connected to the device');
      try {
        connection.output.add(utf8.encode('0' + '\r\n'));
        await connection.output.allSent;

        connection.input.listen(receive).onDone(() {
          //Data entry point
          print('성공');
          update();
        });
      } catch (exception) {
        print("수신 오류");
        print(exception);
      }
    } catch (exception) {
      print('커넥트 결과: Cannot connect, exception occured');
    }
  }
}
