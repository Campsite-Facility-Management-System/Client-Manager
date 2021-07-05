import 'package:client_manager/container/homePage/profile.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'model/campTile.dart';

class CampList extends StatelessWidget {
  final token = new FlutterSecureStorage();
  var resCount = '0';
  var ordCount = '0';
  List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(homePageGetX());

    return Obx(
      () => Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 620,
        child: ListView.builder(
          itemCount: campList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ProfileScreen();
            } else {
              return CampTile.buildTile(context, campList[index - 1]);
            }
            // print("index: " + index.toString());
            // print("list index: " + list[index].toString());
          },
        ),
      ),
    );
  }
}
