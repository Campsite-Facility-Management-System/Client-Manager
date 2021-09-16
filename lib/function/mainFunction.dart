import 'package:client_manager/container/homePage/profile.dart';
import 'package:client_manager/getX/token/tokenGetX.dart';
import 'package:client_manager/screen/homePage/homePageScreen.dart';
import 'package:client_manager/screen/myPage/myPageScreen.dart';
import 'package:client_manager/screen/notificationPage/notiPageScreen.dart';
import 'package:client_manager/screen/statistics/statisticsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MainFunction extends StatefulWidget {
  @override
  _MainFunctionState createState() => _MainFunctionState();
}

class _MainFunctionState extends State<MainFunction> {
  final token = new FlutterSecureStorage();
  List<String> campNameList = [];
  List<String> campIdList = [];
  var selected;
  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final tokenController = Get.put(TokenGetX());

    return WillPopScope(
      key: tokenController.globalKey,
      onWillPop: exit_app

      // () async {
      //   bool result = tokenController.end();
      //   return await Future.value(result);
      // }
      ,
      child: Scaffold(
        drawer: leftMenu(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Get.to(NotiPageScreen());
                },
                icon: Icon(Icons.notifications))
          ],
        ),
        body: HomePageScreen(),
      ),
    );
  }

  Future<bool> exit_app() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: '한 번 더 누르면 앱을 종료합니다.');
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget leftMenu() {
    final tokenController = Get.put(TokenGetX());
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            height: 150,
            child: DrawerHeader(
              child: Container(
                alignment: Alignment.centerLeft,
                child: ProfileScreen(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              onTap: () {
                Get.back();
                Get.to(() => StatisticsScreen());
              },
              leading: Icon(
                Icons.analytics,
                color: Colors.green,
              ),
              title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '통계',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              onTap: () {
                Get.back();
                Get.to(() => MyPageScreen());
              },
              leading: Icon(
                Icons.charging_station_rounded,
                color: Colors.green,
              ),
              title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '포인트 충전소',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            alignment: Alignment.topLeft,
            height: 30,
            child: RaisedButton(
              color: Colors.green,
              onPressed: () => tokenController.logout(),
              child: Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
