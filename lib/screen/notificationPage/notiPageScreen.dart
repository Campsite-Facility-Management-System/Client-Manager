import 'package:client_manager/getX/Notification/Noti_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotiPageScreen extends StatelessWidget {
  final noti_Controller = Get.put(Noti_Controller());

  @override
  Widget build(BuildContext context) {
    noti_Controller.api_noti_list();

    var current_time = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        title: Text(
          '알림',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ),
      body: Obx(
        () => Container(
          child: SingleChildScrollView(
            controller: noti_Controller.scrollController,
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: noti_Controller.noti_list.length,
                  itemBuilder: (context, index) => Container(
                    height: MediaQuery.of(context).size.height / 9,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: const Color(0xffEBEEF5),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  noti_Controller.noti_list[index]['title'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xffFEBA47),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  noti_Controller.noti_list[index]['body'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            ((() {
                              String result;
                              var time = DateTime.now().difference(
                                  DateTime.parse(noti_Controller
                                      .noti_list[index]['updated_at']));
                              if (time.inSeconds == 0) {
                                result = '방금전';
                              } else if (time.inSeconds < 60) {
                                result = time.inSeconds.toString() + '초 전';
                              } else if (time.inMinutes < 60) {
                                result = time.inMinutes.toString() + '분 전';
                              } else if (time.inHours < 24) {
                                result = time.inHours.toString() + '시간 전';
                              } else if (time.inDays < 30) {
                                result = time.inDays.toString() + '일 전';
                              } else if (time.inDays > 30 &&
                                  time.inDays < 365) {
                                result = (time.inDays / 30).toString() + '달 전';
                              } else if (time.inDays > 365) {
                                result = (time.inDays / 365).toString() + '년 전';
                              } else {
                                result = time.inDays.toString() + '일 전';
                              }

                              return result;
                            }())),
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xffBABEC8),
                            ),
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
      ),
    );
  }
}
