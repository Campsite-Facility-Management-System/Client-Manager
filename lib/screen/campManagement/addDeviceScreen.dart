import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/getX/campManagement/setDeviceGetX.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/screen/campManagement/searchDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

// class AddDeviceScreen extends StatefulWidget {
//   @override
//   AddDeviceScreenState createState() => AddDeviceScreenState();
// }

class AddDeviceScreen extends StatelessWidget {
  var uuid;
  TextEditingController _name = new TextEditingController();
  final token = new FlutterSecureStorage();
  final homepageController = Get.put(homePageGetX());
  var selected;
  var selectedId;

  @override
  Widget build(BuildContext context) {
    final campDetailController = Get.put(CampDetailGetX());
    final setDeviceController = Get.put(SetDeviceGetX());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '디바이스 추가',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => Text(setDeviceController
                                                  .connectedWifiName.value ==
                                              ''
                                          ? '블루투스로 장치를 검색하세요'
                                          : setDeviceController
                                              .connectedWifiName.value
                                              .toString()),
                                    ),
                                  ),
                                  RaisedButton(
                                      child: Text('블루투스 검색'),
                                      onPressed: () => {
                                            Get.to(() => SearchDeviceScreen()),
                                          }),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '디바이스 이름을 입력하세요'),
                                controller: _name,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Text('카테고리를 선택하세요'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 5,
                        ),
                        FutureBuilder(
                          future: setDeviceController.apiCategoryList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData == false) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('error'),
                              );
                            } else {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    setDeviceController.categoryList.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => InkWell(
                                      onTap: () {
                                        setDeviceController
                                            .selected_Category_Index
                                            .value = index;
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            color: setDeviceController
                                                        .selected_Category_Index
                                                        .value ==
                                                    index
                                                ? Colors.green
                                                : Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            alignment: Alignment.centerLeft,
                                            height: 50,
                                            child: Text(setDeviceController
                                                .categoryList
                                                .value[index]
                                                .name),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            setDeviceController.upload(
                              _name.text,
                              setDeviceController
                                  .categoryList
                                  .value[setDeviceController
                                      .selected_Category_Index.value]
                                  .id,
                              homepageController.selectedCampId,
                            );
                          },
                          child: Text('등록하기'),
                        ),
                      ),
                    ],
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
