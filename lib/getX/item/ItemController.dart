import 'dart:convert';

import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/getX/item/model/json_goods_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ItemController extends GetxController {
  var itemList = [].obs;
  final token = new FlutterSecureStorage();
  var jsonData;

  apiGoodsList(campId) async {
    var url = Env.url + '/api/goods/manager/list?camp_id=' + campId.toString();
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll({'Authorization': myToken.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      jsonData = JsonGoodsList.fromJson(await jsonDecode(data));

      itemList.clear();
      for (var i = 0; i < jsonData.data.length; i++) {
        itemList.value.add(jsonData.data[i]);
      }
      update();
    } else {
      print(response.reasonPhrase);
    }
  }

  apiGoodsListNext() async {
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
        jsonData = JsonGoodsList.fromJson(await jsonDecode(data));

        for (var i = 0; i < jsonData.data.length; i++) {
          itemList.value.add(jsonData.data[i]);
        }
        update();
        print(itemList.length);
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
