import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_manager/container/homePage/campList.dart';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/screen/campManagement/addCampScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatelessWidget {
  final token = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(homePageGetX());

    return Scaffold(
      body: Obx(
        () => ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    homePageController.page.value =
                        homePageController.pageController.page.toInt();
                    print(homePageController.page.toString());
                  }
                  return;
                },
                child: PageView.builder(
                  onPageChanged: (pos) {
                    homePageController.currentPage.value = pos;
                  },
                  physics: BouncingScrollPhysics(),
                  controller: homePageController.pageController,
                  itemCount: campList.length,
                  itemBuilder: (context, index) {
                    return campImg(Env.url + campList[index]['img_url']);
                  },
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  campList[homePageController.currentPage.toInt()]['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  campList[homePageController.currentPage.toInt()]['address'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddCampScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget campImg(String image) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 220,
        width: 170,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(image),
          ),
        ),
      ),
    );
  }
}
