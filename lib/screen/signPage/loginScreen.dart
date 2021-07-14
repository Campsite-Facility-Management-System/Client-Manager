import 'package:client_manager/getX/fcm/notification_controller.dart';
import 'package:client_manager/getX/token/tokenGetX.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noti = Get.put(Notification_Controller());
    final tokenController = Get.put(TokenGetX());
    return WillPopScope(
      onWillPop: () async {
        bool result = tokenController.end();
        return await Future.value(result);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Container(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100),
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset('icon/color-brown copy.jpg')),
                  SizedBox(height: 10),
                  Text(
                    '모닥모닥',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.brown,
                          ),
                        ),
                      ]),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'ID'),
                    controller: _email,
                  ),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Password',
                            style: TextStyle(
                              color: Colors.brown,
                            )),
                      ]),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Password'),
                    obscureText: true,
                    controller: _passwd,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () => noti.notify(),
                      // tokenController.login(_email.text, _passwd.text),
                      child: Text(
                        '로그인',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () => Get.to(SignUpScreen()),
                        child: Text(
                          '회원가입',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
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
