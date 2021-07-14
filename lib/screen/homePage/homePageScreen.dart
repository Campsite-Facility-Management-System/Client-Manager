import 'package:client_manager/container/homePage/campList.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/screen/campManagement/addCampScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatelessWidget {
  final token = new FlutterSecureStorage();

  // final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  // static DateTime pressBack;

  // _end() {
  //   DateTime now = DateTime.now();
  //   if (pressBack == null || now.difference(pressBack) > Duration(seconds: 2)) {
  //     pressBack = now;
  //     _globalKey.currentState
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(
  //         SnackBar(
  //           content: Text('한번 더 누르면 앱을 종료합니다'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     return false;
  //   } else {
  //     SystemNavigator.pop();
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(homePageGetX());
    homePageController.apiCampList();

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Side menu FlutterCorner',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('전력 제어'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '내 캠핑장',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              CampList(),
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
}
