import 'dart:convert';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/item/model/json_order_list/json_order_list.dart';
import 'package:client_manager/getX/reservation/model/json_rsv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RsvController extends GetxController {
  var rsvList = [].obs;
  final token = new FlutterSecureStorage();
  var jsonData;

  apiRsvList(campId) async {
    var url =
        Env.url + '/api/reservation/manager/list?camp_id=' + campId.toString();
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll({'Authorization': myToken.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      jsonData = JsonRsv.fromJson(await jsonDecode(data));

      print(data);
      rsvList.clear();
      for (var i = 0; i < jsonData.data.length; i++) {
        rsvList.value.add(jsonData.data[i]);
      }
      print(rsvList.length);
      update();
    } else {
      update();
      print(response.reasonPhrase);
    }
  }

  apiRsvListNext() async {
    var url = jsonData.links.next;

    print(url);
    if (url != null) {
      String value = await token.read(key: 'token');
      String myToken = ("Bearer " + value);

      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll({'Authorization': myToken});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        jsonData = JsonRsv.fromJson(await jsonDecode(data));

        for (var i = 0; i < jsonData.data.length; i++) {
          rsvList.value.add(jsonData.data[i]);
        }
        update();
        print(rsvList.length);
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
