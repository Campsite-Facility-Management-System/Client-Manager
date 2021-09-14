import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:client_manager/function/env.dart';
import 'package:client_manager/function/mainFunction.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
import 'package:client_manager/screen/campManagement/models/json_category_list.dart';
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
  var categoryList = List<JsonCategoryList>().obs;
  var password;
  var uuid;
  var wifiList = [];
  var selectedWifi = 0.obs;
  int count = 0;
  var selected_Category_Index = 0.obs;
  var connectedWifiName = ''.obs;
  var isSending = false.obs;

  @override
  onInit() {
    super.onInit();
    apiCategoryList();
  }

  apiCategoryList() async {
    print('run');
    final home_Controller = Get.put(homePageGetX());

    var url = Env.url + '/api/category/manager/list';
    String value = await token.read(key: 'token');
    var headers = {
      'Authorization': 'Bearer ' + value.toString(),
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields
        .addAll({'campsite_id': home_Controller.selectedCampId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      categoryList.value.clear();

      var data = jsonDecode(await response.stream.bytesToString());

      for (var i = 0; i < data.length; i++) {
        categoryList.value.add(JsonCategoryList.fromJson(data[i]));
      }

      return categoryList;
    } else {
      print(response.reasonPhrase);
    }
  }

  upload(deviceName, categoryId, campsiteId) async {
    var url = Env.url + '/api/device/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken.toString()});
    request.fields.addAll({
      'name': deviceName.toString(),
      'uuid': uuid.toString(),
      'category_id': categoryId.toString(),
      'campsite_id': campsiteId.toString(),
    });

    print('토큰 : ' + myToken.toString());
    print('디바이스: ' + deviceName.toString());
    print('카테고리id: ' + categoryId.toString());
    print('캠프id: ' + campsiteId.toString());
    print('uuid: ' + uuid.toString());

    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase.toString());
    print(response.stream.bytesToString());

    if (response.statusCode == 200) {
      Get.back();
    } else if (response.statusCode == 401) {
      // print("error");
    }
  }

  connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('커넥트 결과: Connected to the device');
      try {
        connection.output.add(utf8.encode('0' + '\r\n'));
        await connection.output.allSent;

        connection.input.listen((data) {
          if (count == 0) {
            wifiList.clear();

            print('수신 데이터: ' + Utf8Decoder().convert(data));

            var tmp = Utf8Decoder().convert(data).split(',');
            for (int i = 0; i < tmp.length - 1; i++) {
              wifiList.add(tmp[i]);
            }
            print('와이파이 리스트: ' + wifiList.toString());
            print('선택된 리스트: ' + selectedWifi.toString());

            count++;
            update();
            isSending.value = false;
          } else if (count == 1) {
            var tmp = Utf8Decoder().convert(data).split(',');
            print('tmp: ' + tmp.toString());
            if (tmp[0] == '0') {
              print("error");
            } else {
              connectedWifiName.value = wifiList[selectedWifi.value].toString();
              uuid = tmp[1].toString();
              print('uuid + ' + uuid.toString());
              update();
              count = 0;
              connection.finish();
              Get.back();
            }
            isSending.value = false;

          }
        }).onDone(() {
          print('onDone');
          count = 0;
          connection.finish();              
          isSending.value = false;
        });
      } catch (exception) {
        print("수신 오류");
        print(exception);
        isSending.value = false;

      }
    } catch (exception) {
      print('커넥트 결과: Cannot connect, exception occured');
      isSending.value = false;

    }
  }

  sendWifiData(address, password) async {
    isSending.value = true;
    connection.output.add(utf8.encode(wifiList[selectedWifi.value].toString() +
        ',' +
        password.toString() +
        '\r\n'));
    print(wifiList[selectedWifi.value].toString() +
        ',' +
        password.toString() +
        '\r\n');
    await connection.output.allSent;
  }

  // passReceive(Uint8List data) {
  //   print("수신 데이터!!" + Utf8Decoder().convert(data));

  //   var tmp = Utf8Decoder().convert(data).split(',');
  //   print(tmp);
  //   if (tmp[0] == '0') {
  //     print("error");
  //   } else {
  //     uuid = tmp[1];
  //     print(uuid);
  //   }
  //   count = 0;

  //   print('성공!!!');
  //   connection.finish();
  //   Get.back();
  //   connection.finish();
  // }
}
