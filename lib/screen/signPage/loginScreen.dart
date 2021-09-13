import 'package:client_manager/function/mainFunction.dart';
import 'package:client_manager/getX/fcm/notification_controller.dart';
import 'package:client_manager/getX/token/tokenGetX.dart';
import 'package:client_manager/main.dart';
import 'package:client_manager/screen/homePage/homePageScreen.dart';
import 'package:client_manager/screen/signPage/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _passwd = new TextEditingController();
  final token = new FlutterSecureStorage();
  final tokenController = Get.put(TokenGetX());

  @override
  void initState() {
    super.initState();
    check();
  }

  check() async {
    if (await tokenController.tokenCheck()) {
      Get.off(() => MainFunction());
    }
  }

  @override
  Widget build(BuildContext context) {
    final noti = Get.put(Notification_Controller());
    return WillPopScope(
      onWillPop: () async {
        bool result = tokenController.end();
        return await Future.value(result);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100, bottom: 30),
                    height: 300,
                    width: 300,
                    child: Image.asset('icon/color-brown copy.jpg'),
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      'MODAK MODAK ADMIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xff402015),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color(0xff0abf52),
                          ),
                        ),
                      ),
                      controller: _email,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    width: 220,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: const Color(0xff0abf52),
                            ),
                          ),
                          hintText: 'PW'),
                      obscureText: true,
                      controller: _passwd,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 220,
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 3,
                      color: const Color(0xff0abf52),
                      onPressed: () =>
                          tokenController.login(_email.text, _passwd.text),
                      child: Text(
                        '로그인',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(SignUpScreen()),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                          color: const Color(0xff0abf52), fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
