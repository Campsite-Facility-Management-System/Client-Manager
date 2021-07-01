// import 'package:client_manager/function/env.dart';
// import 'package:client_manager/container/homePage/model/myInfo.dart';
// import 'package:client_manager/function/token/tokenFunction.dart';
// import 'package:client_manager/provider/idCollector.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:provider/provider.dart';

// class Gateway {
//   final token = new FlutterSecureStorage();
//   final tokenFunction = new TokenFunction();

//   Future<MyInfo> me(context) async {
//     tokenFunction.tokenCheck(context);

//     var url = Env.url + '/api/auth/me';
//     String value = await token.read(key: 'token');
//     String myToken = ("Bearer " + value);

//     final response = await http.post(Uri.parse(url), headers: {
//       'Authorization': myToken,
//     });

//     Map<String, dynamic> list = jsonDecode(response.body);

//     return MyInfo(
//       nick: list['nick_name'],
//       point: list['point'].toString(),
//       img_url: list['profile_img'].toString(),
//     );
//   }

//   Future<List<dynamic>> apiCampList(context) async {
//     tokenFunction.tokenCheck(context);

//     List<dynamic> campList;
//     var url = Env.url + '/api/campsite/manager/list';
//     String value = await token.read(key: 'token');
//     String myToken = ("Bearer " + value.toString());

//     var response = await http.post(Uri.parse(url), headers: {
//       'Authorization': myToken,
//     });

//     var d = utf8.decode(response.bodyBytes);
//     campList = jsonDecode(d) as List;

//     return campList;
//   }

//   Future<Null> apiCategoryList(context) async {
//     tokenFunction.tokenCheck(context);

//     var url = Env.url + '/api/category/manager/list';
//     String value = await token.read(key: 'token');
//     String myToken = ("Bearer " + value);
//     List<dynamic> categoryList;

//     var response = await http.post(Uri.parse(url), headers: {
//       'Authorization': myToken,
//     }, body: {
//       'campsite_id': Provider.of<IdCollector>(context, listen: true)
//           .selectedCampId
//           .toString(),
//     });
//     var data = utf8.decode(response.bodyBytes);
//     categoryList = jsonDecode(data) as List;

//     for (var i = 0; i < categoryList.length; i++) {
//       Provider.of<IdCollector>(context, listen: true)
//           .setCMap(categoryList[i]['id'], categoryList[i]['name']);
//     }
//   }
// }
