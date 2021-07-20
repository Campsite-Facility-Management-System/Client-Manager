import 'package:client_manager/container/homePage/model/myInfo.dart';
import 'package:client_manager/function/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var campList = List<dynamic>().obs;

class homePageGetX extends GetxController {
  final token = FlutterSecureStorage();
  PageController pageController;
  double viewPortFraction = 0.5;
  var currentPage = 0.obs;
  var page = 0.obs;

  @override
  onInit() {
    super.onInit();
    apiCampList();
    pageController = PageController(
        initialPage: currentPage.toInt(), viewportFraction: viewPortFraction);
  }

  Future<MyInfo> me() async {
    var url = Env.url + '/api/auth/me';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    final response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    });

    Map<String, dynamic> list = jsonDecode(response.body);

    return MyInfo(
      nick: list['nick_name'],
      point: list['point'].toString(),
      img_url: list['profile_img'].toString(),
    );
  }

  apiCampList() async {
    var url = Env.url + '/api/campsite/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value.toString());

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    });

    campList.value = jsonDecode(utf8.decode(response.bodyBytes)) as List;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
