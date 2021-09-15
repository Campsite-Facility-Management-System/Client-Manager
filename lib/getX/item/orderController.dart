import 'dart:convert';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/item/model/json_goods_list/json_goods_list.dart';
import 'package:client_manager/getX/item/model/json_order_list/json_order_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  var orderList = [].obs;
  final token = new FlutterSecureStorage();
  var jsonData;

  apiOrderList(campId) async {
    var url = Env.url + '/api/order/manager/list?camp_id=' + campId.toString();
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll({'Authorization': myToken.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      jsonData = JsonOrderList.fromJson(await jsonDecode(data));

      print(data);
      orderList.clear();
      for (var i = 0; i < jsonData.data.length; i++) {
        orderList.value.add(jsonData.data[i]);
      }
      print(orderList.length);
      update();
    } else {
      print(response.reasonPhrase);
    }
  }

  apiOrderListNext() async {
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
        jsonData = JsonOrderList.fromJson(await jsonDecode(data));

        for (var i = 0; i < jsonData.data.length; i++) {
          orderList.value.add(jsonData.data[i]);
        }
        update();
        print(orderList.length);
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
