import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/getX/campManagement/setDeviceGetX.dart';
import 'package:client_manager/screen/campManagement/searchDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  AddDeviceScreenState createState() => AddDeviceScreenState();
}

class AddDeviceScreenState extends State<AddDeviceScreen> {
  var uuid;
  TextEditingController _name = new TextEditingController();
  final token = new FlutterSecureStorage();

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
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text('블루투스로 장치를 검색하세요'),
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
                              hintText: '디바이스 이름'),
                          controller: _name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('카테고리 선택'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text('category'),
                            );
                          },
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: DropdownButton(
                        //         value: selected,
                        //         items: campDetailController.cMap.keys.map(
                        //           (value) {
                        //             return
                        //             DropdownMenuItem(
                        //               value: value,
                        //               child: Text(value),
                        //             );
                        //           },
                        //         ).toList(),
                        //         onChanged: (value) {
                        //           setState(() {
                        //             selected = value;
                        //             selectedId =
                        //                 campDetailController.cMap[selected];
                        //             print("selected: " + selected);
                        //             print(campDetailController.cMap[selected]);
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        onPressed: () => setDeviceController.upload(
                          _name.text,
                          campDetailController.cMap[selected],
                          campDetailController.selectedCampId,
                        ),
                        child: Text('등록하기'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
