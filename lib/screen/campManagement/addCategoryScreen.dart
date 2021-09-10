import 'package:client_manager/function/env.dart';
import 'package:client_manager/function/addPicture.dart';
import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/screen/campManagement/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

List<dynamic> imageList = List(6);

class AddCategoryScreen extends StatefulWidget {
  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _max_car_num = new TextEditingController();
  TextEditingController _max_adult_num = new TextEditingController();
  TextEditingController _max_children_num = new TextEditingController();
  TextEditingController _max_energy = new TextEditingController();
  final token = new FlutterSecureStorage();
  final listController = Get.put(ElectricInfoGetX());

  getimage(imagePath, index) {
    imageList[index] = imagePath;

    for (int i = 0; i < 6; i++) {
      print("index: " + i.toString() + " : " + imageList[i].toString());
    }
  }

  upload() async {
    var url = Env.url + '/api/category/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    final campDetailController = Get.put(CampDetailGetX());
    final home_Controller = Get.put(homePageGetX());

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'campsite_id': home_Controller.selectedCampId.toString(),
      'name': _name.text,
      'price': _price.text,
      'description': _description.text,
      'max_car_num': _max_car_num.text,
      'max_adult_num': _max_adult_num.text,
      'max_children_num': _max_children_num.text,
      'max_energy': _max_energy.text
    });

    for (int i = 0; i < 6; i++) {
      if (imageList[i] != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img[]', imageList[i]));
      }
    }

    print(home_Controller.selectedCampId.toString());
    var response = await request.send();

    if (response.statusCode == 200) {
      listController.apiElectricCategoryList();
      Get.back();
    } else {
      print('aaa: ' + response.reasonPhrase.toString());
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '카테고리 추가',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: AddPicture(200, 200, '대표 사진', 0, 2),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            children: [
                              AddPicture(200, 160, '', 1, 2),
                              AddPicture(200, 160, '', 2, 2),
                              AddPicture(200, 160, '', 3, 2),
                              AddPicture(200, 160, '', 4, 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '카테고리 이름',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _name,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '가격',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _price,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            maxLines: 5,
                            maxLength: 200,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '카테고리 설명',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _description,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 20,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '최대 차량수',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _max_car_num,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 20,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '최대 성인수',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _max_adult_num,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 20,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '최대 미성년자수',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _max_children_num,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 20,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '최대 부하량',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: const Color(0xff0abf52)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _max_energy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonTheme(
                          height: 50,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15),
                            ),
                            splashColor: const Color(0xff0abf52),
                            color: const Color(0xff0abf52),
                            onPressed: () => upload(),
                            child: Text(
                              '등록하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: SingleChildScrollView(
  //         child: Container(
  //           padding: EdgeInsets.only(left: 20, right: 20),
  //           child: Column(
  //             children: <Widget>[
  //               SizedBox(
  //                 height: 100,
  //               ),
  //               Text(
  //                 '카테고리 추가',
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //               Text('대표사진(필수)'),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Container(
  //                 width: 350,
  //                 height: 200,
  //                 child: AddPicture(350, 250, 'a', 0, 2),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Text('추가 사진(최대 5개)'),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Container(
  //                     width: 50,
  //                     height: 50,
  //                     child: AddPicture(350, 250, 'a', 0, 2),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Container(
  //                     width: 50,
  //                     height: 50,
  //                     child: AddPicture(350, 250, 'a', 0, 2),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Container(
  //                     width: 50,
  //                     height: 50,
  //                     child: AddPicture(350, 250, 'a', 0, 2),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Container(
  //                     width: 50,
  //                     height: 50,
  //                     child: AddPicture(350, 250, 'a', 0, 2),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   Container(
  //                     width: 50,
  //                     height: 50,
  //                     child: AddPicture(350, 250, 'a', 0, 2),
  //                   ),
  //                 ],
  //               ),
  //               Container(
  //                 padding: EdgeInsets.only(left: 20, right: 20, top: 20),
  //                 child: Form(
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Text('카테고리 이름'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             hintText: '카테고리 이름'),
  //                         controller: _name,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('가격'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(), hintText: '가격'),
  //                         controller: _price,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('카테고리 설명'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             hintText: '카테고리 설명'),
  //                         controller: _description,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('최대 차량 수'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             hintText: '최대 차량 수'),
  //                         controller: _max_car_num,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('최대 성인 수'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             hintText: '최대 성인 수'),
  //                         controller: _max_adult_num,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('최대 미성년자 수'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(),
  //                             hintText: '최대 미성년자 수'),
  //                         controller: _max_children_num,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('최대 부하량'),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                             border: OutlineInputBorder(), hintText: '최대 부하량'),
  //                         controller: _max_energy,
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               RaisedButton(
  //                 onPressed: () => upload(),
  //                 child: Text('등록하기'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
