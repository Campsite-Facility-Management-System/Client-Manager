import 'package:client_manager/container/homePage/model/myInfo.dart';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:client_manager/getX/item/ItemController.dart';
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
  var currentPage = 0.obs; //캠핑장 인덱스
  var page = 0.obs;
  var selectedCampId = ''.obs;
  var tab = 0.obs; //예약내역(0), 물품내역(1)

  ScrollController scrollController = ScrollController();
  final itemController = Get.put(ItemController());

  void event() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        switch (tab.value) {
          case 1:
            itemController.apiGoodsListNext();
            break;
          case 2:
            break;
          case 3:
            break;
        }
      }
    });
  }

  @override
  onInit() {
    super.onInit();
    apiCampList();
    pageController = PageController(
        initialPage: currentPage.toInt(), viewportFraction: viewPortFraction);

    event();
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
      nick: list['nickname'],
      point: list['point'].toString(),
      img_url: list['profile_img_url'].toString(),
    );
  }

  apiCampList() async {
    var url = Env.url + '/api/campsite/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value.toString());

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': myToken,
    });

    var data = utf8.decode(response.bodyBytes);
    campList.value = jsonDecode(data) as List;

    if (campList.length != 0) {
      selectedCampId.value = campList[0]['id'].toString();
      final electric_Controller = Get.put(ElectricInfoGetX());
      electric_Controller.apiElectricCategoryList();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
