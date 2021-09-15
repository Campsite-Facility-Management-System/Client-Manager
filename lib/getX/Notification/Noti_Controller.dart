import 'dart:convert';
import 'package:client_manager/function/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Noti_Controller extends GetxController {
  final token = FlutterSecureStorage();
  var noti_list = [].obs;
  var data;
  ScrollController scrollController = ScrollController();

  @override
  onInit() {
    super.onInit();
    _event();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        api_noti_list_next();
      }
    });
  }

  api_noti_list() async {
    noti_list.clear();

    var headers = await token.read(key: 'token');

    var request = http.Request('GET', Uri.parse(Env.url + '/api/noty/list'));

    request.headers.addAll({'Authorization': 'Bearer ' + headers.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(await response.stream.toBytes()));
      for (var i = 0; i < data['data'].length; i++) {
        noti_list.add(data['data'][i]);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  api_noti_list_next() async {
    var headers = await token.read(key: 'token');
    var url_camp_list_next = data['next_page_url'];

    print(url_camp_list_next);
    if (url_camp_list_next != null) {
      var request = http.Request('GET', Uri.parse(url_camp_list_next));

      request.headers.addAll({'Authorization': 'Bearer ' + headers.toString()});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        data = jsonDecode(utf8.decode(await response.stream.toBytes()));

        for (var i = 0; i < data['data'].length; i++) {
          noti_list.add(data['data'][i]);
        }
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
