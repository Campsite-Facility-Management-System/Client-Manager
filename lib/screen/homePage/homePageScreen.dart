import 'package:client_manager/container/homePage/campList.dart';
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
    homePageController.apiCampList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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
