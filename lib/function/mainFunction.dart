import 'package:client_manager/container/homePage/profile.dart';
import 'package:client_manager/getX/token/tokenGetX.dart';
import 'package:client_manager/screen/electric/electricManager.dart';
import 'package:client_manager/screen/homePage/homePageScreen.dart';
import 'package:client_manager/screen/morePage/morePageScreen.dart';
import 'package:client_manager/screen/notificationPage/notiPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  @override
  Widget build(BuildContext context) {
    final tokenController = Get.put(TokenGetX());

    return WillPopScope(
      key: tokenController.globalKey,
      onWillPop: () async {
        bool result = tokenController.end();
        return await Future.value(result);
      },
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
              },
              leading: Icon(
                Icons.home,
                color: Colors.green,
              ),
              title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '메인',
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
              },
              leading: Icon(
                Icons.notification_important,
                color: Colors.green,
              ),
              title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '알림내역',
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
              },
              leading: Icon(
                Icons.more,
                color: Colors.green,
              ),
              title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '마이페이지',
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
