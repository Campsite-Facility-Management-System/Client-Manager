import 'package:client_manager/container/electric/electricList/model/electricCategoryTile.dart';
import 'package:client_manager/getX/electric/electricGraphGetX.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ElectricListScreen extends StatefulWidget {
  @override
  ElectricListScreenState createState() => ElectricListScreenState();
}

class ElectricListScreenState extends State<ElectricListScreen> {
  var selectedcampName;
  var selectedIndex;
  var selectedId;
  var campId;
  bool refreshListener = false;
  final token = new FlutterSecureStorage();
  List<String> campNameList = [];
  List<String> campIdList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ElectricInfoGetX());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DropdownButton(
              value: controller.selectedCampName,
              items: controller.campNameList.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  controller.setSelectedCampName(value);
                  selectedIndex = controller.campNameList.indexOf(value);
                  controller
                      .setSelectedCampId(controller.campIdList[selectedIndex]);
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<ElectricInfoGetX>(
              builder: (_) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('새로고침'),
                        onPressed: () => {controller.apiElectricCategoryList()},
                      ),
                      Container(
                        height: 650,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.detailData == null
                                ? 0
                                : controller.detailData?.length,
                            itemBuilder: (context, index) {
                              return ElectricCategoryTile.buildTile(
                                  context, controller.detailData[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
