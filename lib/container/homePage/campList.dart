import 'package:client_manager/function/gateway.dart';
import 'package:client_manager/container/homePage/profile.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'model/campTile.dart';

class CampList extends StatefulWidget {
  @override
  CampListState createState() => CampListState();
}

class CampListState extends State<CampList> {
  final token = new FlutterSecureStorage();
  var resCount = '0';
  var ordCount = '0';
  List<dynamic> list;

  // Future<Null> _getData() async {
  //   list = await gateway.apiCampList(context);

  //   setState(() {
  //     list;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getData();
  // }

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(homePageGetX());

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 620,
      child: ListView.builder(
        itemCount: homePageController.campList == null
            ? 0
            : homePageController.campList?.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ProfileScreen();
          } else {
            return CampTile.buildTile(
                context, homePageController.campList[index - 1]);
          }
          // print("index: " + index.toString());
          // print("list index: " + list[index].toString());
        },
      ),
    );
  }
}
