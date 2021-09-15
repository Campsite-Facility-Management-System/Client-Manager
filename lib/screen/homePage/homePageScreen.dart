import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/getX/item/ItemController.dart';
import 'package:client_manager/getX/item/orderController.dart';
import 'package:client_manager/getX/reservation/rsvController.dart';
import 'package:client_manager/screen/campManagement/addCampScreen.dart';
import 'package:client_manager/screen/campManagement/addCategoryScreen.dart';
import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
import 'package:client_manager/screen/electric/electricScreen.dart';
import 'package:client_manager/screen/itemManagement/addBuyScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatelessWidget {
  final token = new FlutterSecureStorage();
  final itemController = Get.put(ItemController());
  final orderController = Get.put(OrderController());
  final rsvController = Get.put(RsvController());

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(homePageGetX());
    final electricController = Get.put(ElectricInfoGetX());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => campList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: homePageController.scrollController,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                            homePageController.selectedCampId.value = campList
                                .value[homePageController.page.value]['id']
                                .toString();
                            switch (homePageController.tab.value) {
                              case 0: 
                                electricController.apiElectricCategoryList();
                                break;
                              case 1: 
                                itemController.apiGoodsList(homePageController.selectedCampId.value);
                                break;
                              case 2: 
                                rsvController.apiRsvList(homePageController.selectedCampId.value);
                                break;
                              case 3: 
                                orderController.apiOrderList(homePageController.selectedCampId.value);
                                break;
                            }
                            
                          }
                          return;
                        },
                        child: PageView.builder(
                          onPageChanged: (pos) async {
                            homePageController.currentPage.value = pos;
                            // electricController.selectedCampId.value =
                            //     campList[homePageController.currentPage.toInt()]
                            //             ['id']
                            //         .toString();
                            switch (homePageController.tab.value) {
                              case 0:
                                await electricController
                                    .apiElectricCategoryList();
                                break;
                              case 1:
                                await itemController.apiGoodsList(
                                    homePageController.selectedCampId);
                                break;
                              case 2:
                                await orderController.apiOrderList(
                                    homePageController.selectedCampId);
                                break;
                              case 3:
                                await rsvController.apiRsvList(homePageController.selectedCampId);
                                break;
                            }
                          },
                          physics: BouncingScrollPhysics(),
                          controller: homePageController.pageController,
                          itemCount: campList.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                campImg(Env.url + campList[index]['img_url']),
                                // Positioned(
                                //   top: 0,
                                //   right: 15,
                                //   child: IconButton(
                                //     onPressed: () {
                                //       //캠핑장 정보 수정
                                //     },
                                //     icon: Icon(
                                //       Icons.settings,
                                //       color: Colors.green,
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
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
                                  onTap: () async {
                                    homePageController.tab.value = 0;
                                    await electricController
                                        .apiElectricCategoryList();
                                  },
                                  child: Container(
                                    color: homePageController.tab.value == 0
                                        ? Colors.lightGreen
                                        : Colors.white,
                                    child: Center(
                                      child: Text(
                                        '전력관리',
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
                                  onTap: () async {
                                    homePageController.tab.value = 1;
                                    await itemController.apiGoodsList(
                                        homePageController.selectedCampId);
                                  },
                                  child: Container(
                                    color: homePageController.tab.value == 1
                                        ? Colors.lightGreen
                                        : Colors.white,
                                    child: Center(
                                      child: Text(
                                        '물품관리',
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
                        Container(
                          height: 30,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    homePageController.tab.value = 2;
                                    await rsvController.apiRsvList(homePageController.selectedCampId);
                                  },
                                  child: Container(
                                    color: homePageController.tab.value == 2
                                        ? Colors.lightGreen
                                        : Colors.white,
                                    child: Center(
                                      child: Text(
                                        '예약내역',
                                        style: TextStyle(
                                          fontSize:
                                              homePageController.tab.value == 2
                                                  ? 16
                                                  : 14,
                                          fontWeight:
                                              homePageController.tab.value == 2
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
                                  onTap: () async {
                                    homePageController.tab.value = 3;
                                    await orderController.apiOrderList(
                                        homePageController.selectedCampId);
                                  },
                                  child: Container(
                                    color: homePageController.tab.value == 3
                                        ? Colors.lightGreen
                                        : Colors.white,
                                    child: Center(
                                      child: Text(
                                        '물품주문내역',
                                        style: TextStyle(
                                          fontSize:
                                              homePageController.tab.value == 3
                                                  ? 16
                                                  : 14,
                                          fontWeight:
                                              homePageController.tab.value == 3
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
                        (() {
                          switch (homePageController.tab.value) {
                            case 0:
                              return electric();
                              break;
                            case 1:
                              return item(context);
                              break;
                            case 2:
                              return reservationList();
                              break;
                            case 3:
                              return itemList();
                              break;
                            default:
                          }
                        }()),
                      ],
                    ),
                  ],
                ),
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

  Widget item(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Get.to(() => AddBuyScreen());
                },
                child: Text(
                  '+ 물품 추가',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        GetBuilder<ItemController>(builder: (_) {
          return itemController.itemList.value == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: itemController.itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.1),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: itemController
                                            .itemList.value[index].imgUrl ==
                                        null
                                    ? Center(child: CircularProgressIndicator())
                                    : CachedNetworkImage(
                                        imageUrl: Env.url +
                                            itemController
                                                .itemList.value[index].imgUrl
                                                .toString()),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              itemController.itemList.value[index].name == null
                                  ? ''
                                  : itemController.itemList.value[index].name
                                      .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              itemController.itemList.value[index].price == null
                                  ? ''
                                  : itemController.itemList.value[index].price
                                          .toString() +
                                      '원',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget electric() {
    final electricController = Get.put(ElectricInfoGetX());
    final homePageController = Get.put(homePageGetX());
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(),
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
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  electricController.apiElectricCategoryList();
                },
                icon: Icon(
                  Icons.refresh,
                  color: const Color(0xff999999),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          // 카테고리 타일 동적 생성
          children: List<Widget>.generate(
            electricController.detailData.value == null
                ? 0
                : electricController.detailData.value?.length,
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
                      imageBuilder: (context, imageProvider) => Container(
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: Env.url +
                          electricController.detailData.value[index]['img_url']
                              .toString(),
                    ),
                  ),
                ),
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        electricController.detailData.value[index]['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      electricController
                              .detailData.value[index]['deviceList'].length
                              .toString() +
                          '개',
                      style: TextStyle(
                          color: const Color(0xff999999), fontSize: 12),
                    ),
                  ],
                ),
                // 디바이스 타일 동적 생성
                children: List<Widget>.generate(
                  electricController.detailData.value[index]['deviceList'] ==
                          null
                      ? 0
                      : electricController
                          .detailData.value[index]['deviceList']?.length,
                  (deviceIndex) => InkWell(
                    onTap: () {
                      // graph_Controller.deviceId = electricController.detailData
                      //     .value[index]['deviceList'][deviceIndex]['id'];
                      // graph_Controller.categoryId =
                      //     electricController.detailData.value[index]['id'];
                      // graph_Controller.campId =
                      //     homePageController.selectedCampId.value;
                      Get.to(() => ElectricInfoScreen(electricController
                          .detailData.value[index]['deviceList'][deviceIndex]));
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
                                electricController.detailData.value[index]
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
                              electricController
                                      .detailData
                                      .value[index]['deviceList'][deviceIndex]
                                          ['usage']
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
                            Obx(
                              () => CupertinoSwitch(
                                value: electricController.detailData
                                                .value[index]['deviceList']
                                            [deviceIndex]['state'] ==
                                        '1'
                                    ? true
                                    : false,
                                onChanged: (value) {
                                  electricController.apichangeStatus(
                                      value,
                                      electricController.detailData.value[index]
                                          ['deviceList'][deviceIndex]['id']);
                                },
                              ),
                            ),
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget reservationList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: GetBuilder<RsvController>(builder: (_){
        return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: rsvController.rsvList.value == null? 0:
        rsvController.rsvList.value.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('예약자: ' + rsvController.rsvList.value[index].userName.toString()),
                    Text('예약기간: ' + rsvController.rsvList.value[index].startDate.toString() + ' ~ ' + rsvController.rsvList.value[index].endDate.toString()),
                    Text('카테고리: ' + rsvController.rsvList.value[index].siteTypeName.toString()),
                    Text('디바이스: '+ rsvController.rsvList.value[index].deviceName.toString()),
                    Text('상태: ' + rsvController.rsvList.value[index].status.toString()),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  child: CachedNetworkImage(
                    imageUrl: Env.url + rsvController.rsvList.value[index].imgUrl.toString())),
              ],
            ),

          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
      })
    );
  }

  Widget itemList() {
    return GetBuilder<OrderController>(builder: (_) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: orderController.orderList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('구매자: ' +
                            orderController
                                .orderList.value[index].userNickname),
                        Text('구매물품: ' +
                            orderController.orderList.value[index].goodsName),
                        Text('수량: ' +
                            orderController.orderList.value[index].count
                                .toString()),
                        Text('주문일자: ' +
                            orderController.orderList.value[index].updatedAt
                                .toString()
                                .split('T')[0]),
                        Text('가격: ' +
                            orderController.orderList.value[index].totalPrice
                                .toString() +
                            '원'),
                        Text('배송지: ' +
                            orderController.orderList.value[index].deviceName
                                .toString()),
                        Text(
                          '상태 : ' +
                              (orderController.orderList.value[index].status
                                          .toString()),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CachedNetworkImage(
                        imageUrl: Env.url +
                            orderController.orderList.value[index].imgUrl
                                .toString()),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      );
    });
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
