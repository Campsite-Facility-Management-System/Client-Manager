import 'package:client_manager/getX/campManagement/setDeviceGetX.dart';
import 'package:client_manager/screen/campManagement/searchDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDeviceWifiScreen extends StatefulWidget {
  @override
  SetDeviceWifiScreenState createState() => SetDeviceWifiScreenState();
}

class SetDeviceWifiScreenState extends State<SetDeviceWifiScreen> {
  TextEditingController password = new TextEditingController();
  var selected;

  data() {
    print(password.text);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetDeviceGetX());
    selected = controller.selectedWifi;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '디바이스 WiFi 설정',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Form(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GetBuilder<SetDeviceGetX>(
                        builder: (_) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.wifiList == null
                                ? 0
                                : controller.wifiList.length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => InkWell(
                                  onTap: () {
                                    controller.selectedWifi.value = index;
                                    print(controller.selectedWifi.value);
                                  },
                                  child: Container(
                                    color:
                                        controller.selectedWifi.value == index
                                            ? Colors.green
                                            : Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    child: Text(
                                        controller.wifiList[index].toString()),
                                  ),
                                ),
                              );
                            },
                          );

                          // DropdownButton(
                          //   value: selected,
                          //   items: controller.wifiList.map(
                          //     (value) {
                          //       return DropdownMenuItem(
                          //         value: value,
                          //         child: Text(value),
                          //       );
                          //     },
                          //   ).toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selected = value;
                          //       controller.setSelectedWifi(value);
                          //     });
                          //   },
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'WiFi 비밀번호'),
                  controller: password,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text('연결하기'),
                        onPressed: () => {
                          controller.sendWifiData(password.text),
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
