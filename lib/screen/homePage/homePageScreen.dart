import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_manager/container/homePage/campList.dart';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/screen/campManagement/addCampScreen.dart';
import 'package:client_manager/screen/electric/electricManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatelessWidget {
  final token = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(homePageGetX());
    final listController = Get.put(ElectricInfoGetX());
    final campDetailController = Get.put(CampDetailGetX());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => campList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
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
                          return Stack(
                            children: [
                              campImg(Env.url + campList[index]['img_url']),
                              Positioned(
                                top: 0,
                                right: 15,
                                child: IconButton(
                                  onPressed: () {
                                    listController.setSelectedCampId(campList[
                                            homePageController.currentPage
                                                .toInt()]['id']
                                        .toString());
                                    campDetailController.selectedCampId =
                                        campList[homePageController.currentPage
                                                .toInt()]['id']
                                            .toString();

                                    Get.to(ElectricManager());
                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        campList[homePageController.currentPage.toInt()]
                            ['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        campList[homePageController.currentPage.toInt()]
                            ['address'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  homePageController.tab.value = 0;
                                },
                                child: Container(
                                  color: homePageController.tab.value == 0
                                      ? Colors.lightGreen
                                      : Colors.white,
                                  child: Center(
                                    child: Text(
                                      '예약내역',
                                      style: TextStyle(
                                        fontSize:
                                            homePageController.tab.value == 0
                                                ? 16
                                                : 14,
                                        fontWeight:
                                            homePageController.tab.value == 0
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  homePageController.tab.value = 1;
                                },
                                child: Container(
                                  color: homePageController.tab.value == 1
                                      ? Colors.lightGreen
                                      : Colors.white,
                                  child: Center(
                                    child: Text(
                                      '물품내역',
                                      style: TextStyle(
                                        fontSize:
                                            homePageController.tab.value == 1
                                                ? 16
                                                : 14,
                                        fontWeight:
                                            homePageController.tab.value == 1
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      homePageController.tab.value == 0
                          ? reservationList()
                          : itemList(),
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

  Widget reservationList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('예약자: 모닥'),
                Text('예약기간: 9/23~9/24'),
                Text('카테고리: 글램핑'),
                Text('디바이스: abbc12'),
                Text('상태: 체크인'),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget itemList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('구매자: 모닥'),
                Text('구매물품: 장작'),
                Text('수량: 2'),
                Text('상태: 수령'),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget campImg(String image) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Container(
            height: 190,
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
        ],
      ),
    );
  }
}
