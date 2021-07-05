import 'package:client_manager/container/campManagement/categoryList.dart';
import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class CampDetailScreen extends StatefulWidget {
  @override
  CampDetailScreenState createState() => CampDetailScreenState();
}

class CampDetailScreenState extends State<CampDetailScreen> {
  final token = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CampDetailGetX());
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리/디바이스 목록'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CategoryList(),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.remove,
        visible: true,
        closeManually: false,
        children: [
          SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: Colors.green,
              label: '카테고리',
              onTap: () => Navigator.pushNamed(
                    context,
                    '/addCategory',
                  )),
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.green,
            label: '디바이스',
            onTap: () => Get.to(AddDeviceScreen()),
          ),
        ],
      ),
    );
  }
}
