import 'package:client_manager/function/env.dart';
import 'package:client_manager/function/addPicture.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

List<dynamic> imageList = List(6);

class AddBuyScreen extends StatefulWidget {
  @override
  AddBuyScreenState createState() => AddBuyScreenState();
}

class AddBuyScreenState extends State<AddBuyScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  TextEditingController _info = new TextEditingController();
  final token = new FlutterSecureStorage();
  final homeController = Get.put(homePageGetX());

  getimage(imagePath, index) {
    imageList[index] = imagePath;

    for (int i = 0; i < 6; i++) {
      print("index: " + i.toString() + " : " + imageList[i].toString());
    }
  }

  upload() async {
    var url = Env.url + '/api/goods/manager/create';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'camp_id': homeController.selectedCampId.value.toString(),
      'name': _name.text,
      'price': _price.text,
      'description': _info.text,
    });

    for (int i = 0; i < 6; i++) {
      if (imageList[i] != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img[]', imageList[i]));
      }
    }
    var response = await request.send();

    var data = await response.stream.bytesToString();
    print(data);
    print(imageList);

    if (response.statusCode == 200) {
      Get.back();
    } else if (response.statusCode == 401) {
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
                    '물품 추가',
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
                            child: AddPicture(200, 200, '대표 사진', 0, 3),
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
                              AddPicture(200, 160, '', 1, 3),
                              AddPicture(200, 160, '', 2, 3),
                              AddPicture(200, 160, '', 3, 3),
                              AddPicture(200, 160, '', 4, 3),
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
                              labelText: '물품 이름',
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
                              labelText: '물품 설명',
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
                            controller: _info,
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
}
