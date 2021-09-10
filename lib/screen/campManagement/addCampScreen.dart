import 'package:client_manager/function/env.dart';
import 'package:client_manager/function/addPicture.dart';
import 'package:client_manager/function/mainFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

List<dynamic> imageList = List(6);

class AddCampScreen extends StatefulWidget {
  @override
  AddCampScreenState createState() => AddCampScreenState();
}

class AddCampScreenState extends State<AddCampScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _addr = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _info = new TextEditingController();
  final token = new FlutterSecureStorage();

  getimage(imagePath, index) {
    imageList[index] = imagePath;

    for (int i = 0; i < 6; i++) {
      // print("index: " + i.toString() + " : " + imageList[i].toString());
    }
  }

  upload() async {
    var url = Env.url + '/api/campsite/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': _name.text,
      'telephone': _phone.text,
      'address': _addr.text,
      'description': _info.text,
    });

    for (int i = 0; i < 6; i++) {
      if (imageList[i] != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img[]', imageList[i]));
      }
    }
    var response = await request.send();

    print(response.statusCode);
    print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Get.to(MainFunction());
    } else if (response.statusCode == 401) {}
  }

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
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '캠핑장 추가',
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
                            child: AddPicture(200, 200, '대표 사진', 0, 1),
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
                              AddPicture(200, 160, '', 0, 1),
                              AddPicture(200, 160, '', 0, 1),
                              AddPicture(200, 160, '', 0, 1),
                              AddPicture(200, 160, '', 0, 1),
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
                              labelText: '캠핑장 이름',
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
                              labelText: '캠핑장 주소',
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
                            controller: _addr,
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
                              labelText: '캠핑장 전화번호',
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
                            controller: _phone,
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          elevation: 20,
                          shadowColor: Colors.black38,
                          child: TextFormField(
                            maxLines: 5,
                            maxLength: 200,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '캠핑장 소개',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> image) {
        if (image.connectionState == ConnectionState.done &&
            null != image.data) {
          tmp = image.data;
          base64Image = base64Encode(image.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              image.data,
              fit: BoxFit.fill,
            ),@
          );
        } else {
          return Text(
            '이미지를 선택해주세요',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Text('캠핑장 추가'),
              Text('대표사진'),
              OutlineButton(
                  onPressed: () => getImage(), child: Icon(Icons.add_a_photo)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
