import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotiPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
            size: 20,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: null,
              icon: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  '알림',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 10, right: 20),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://img.freepik.com/free-vector/hand-drawn-summer-camp-background-with-tent-bonfire_23-2147806311.jpg?size=338&ext=jpg',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'Tester 님이 산기대 캠핑장 A-17을 07.19~07.23까지 예약하였습니다',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          '1일 전',
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
