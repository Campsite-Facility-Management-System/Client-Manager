import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_manager/getX/electric/electricGraphGetX.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:client_manager/screen/campManagement/addCategoryScreen.dart';
import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
import 'package:client_manager/screen/electric/electricScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricManager extends StatelessWidget {
  final graph_Controller = Get.put(ElectricGraphGetX());

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(ElectricInfoGetX());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                listController.apiElectricCategoryList();
              },
              icon: Icon(
                Icons.refresh,
                color: const Color(0xff999999),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          '전력 관리',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => AddCategoryScreen());
                        },
                        child: Text(
                          '+ 카테고리 추가',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => AddDeviceScreen());
                        },
                        child: Text(
                          '+디바이스 추가',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  // 카테고리 타일 동적 생성
                  children: List<Widget>.generate(
                    listController.detailData.value == null
                        ? 0
                        : listController.detailData.value?.length,
                    (index) => Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ExpansionTile(
                        iconColor: const Color(0xff0abf52),
                        textColor: Colors.black,
                        initiallyExpanded: false,
                        backgroundColor: Colors.white,
                        leading: Container(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.16),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: Offset(6, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageUrl:
                                  'https://assets.gadgets360cdn.com/img/crypto/dogecoin-og-logo.png',
                            ),
                          ),
                        ),
                        title: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                listController.detailData.value[index]['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              listController.detailData
                                      .value[index]['deviceList'].length
                                      .toString() +
                                  '개',
                              style: TextStyle(
                                  color: const Color(0xff999999), fontSize: 12),
                            ),
                          ],
                        ),
                        // 디바이스 타일 동적 생성
                        children: List<Widget>.generate(
                          listController.detailData.value[index]
                                      ['deviceList'] ==
                                  null
                              ? 0
                              : listController.detailData
                                  .value[index]['deviceList']?.length,
                          (deviceIndex) => InkWell(
                            onTap: () {
                              graph_Controller.deviceId =
                                  listController.detailData.value[index]
                                      ['deviceList'][deviceIndex]['id'];
                              graph_Controller.categoryId =
                                  listController.detailData.value[index]['id'];
                              graph_Controller.campId =
                                  listController.selectedCampId;
                              Get.to(() => ElectricInfoScreen());
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        listController.detailData.value[index]
                                            ['deviceList'][deviceIndex]['name'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: const Color(0xff707070),
                                            shadows: [
                                              Shadow(
                                                blurRadius: 10,
                                                color: Colors.grey,
                                                offset: Offset(0, 3),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Text(
                                      listController
                                              .detailData
                                              .value[index]['deviceList']
                                                  [deviceIndex]['usage']
                                              .toString() +
                                          'kW',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xff999999),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.grey,
                                            offset: Offset(0, 3),
                                          )
                                        ],
                                      ),
                                    ),
                                    CupertinoSwitch(
                                        value: listController.detailData.value[
                                                        index]['deviceList']
                                                    [deviceIndex]['state'] ==
                                                1
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          print("now: " +
                                              listController
                                                  .detailData
                                                  .value[index]['deviceList']
                                                      [deviceIndex]['state']
                                                  .toString());
                                          listController.apichangeStatus(
                                              value,
                                              listController.detailData.value[
                                                      index]['deviceList']
                                                  [deviceIndex]['id']);
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
