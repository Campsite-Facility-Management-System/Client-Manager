import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                '전력 관리',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              // 카테고리 타일 동적 생성
              children: List<Widget>.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    iconColor: const Color(0xff0abf52),
                    textColor: const Color(0xff0abf52),
                    initiallyExpanded: false,
                    backgroundColor: Colors.white,
                    leading: Container(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://hips.hearstapps.com/countryliving.cdnds.net/17/47/1511194376-cavachon-puppy-christmas.jpg'),
                      ),
                    ),
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Category A',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '8개',
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 12),
                        ),
                      ],
                    ),
                    // 디바이스 타일 동적 생성
                    children: List<Widget>.generate(
                      5,
                      (index) => Container(
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
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'D-1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xff999999),
                                  ),
                                ),
                              ),
                              Text(
                                '0kW',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xff999999),
                                ),
                              ),
                            ],
                          ),
                          //스위치
                          trailing: Switch(
                            value: null,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.lightGreen,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
