// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:client_manager/getX/campManagement/manageGetX.dart';
// import 'package:client_manager/getX/electric/electricGraphGetX.dart';
// import 'package:client_manager/getX/electric/electricListGetX.dart';
// import 'package:client_manager/getX/homePage/homePageGetX.dart';
// import 'package:client_manager/screen/campManagement/addCategoryScreen.dart';
// import 'package:client_manager/screen/campManagement/addDeviceScreen.dart';
// import 'package:client_manager/screen/electric/electricScreen.dart';
// import 'package:client_manager/screen/itemManagement/addBuyScreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ElectricManager extends StatelessWidget {
//   final graph_Controller = Get.put(ElectricGraphGetX());
//   final manageController = Get.put(ManageGetX());

//   @override
//   Widget build(BuildContext context) {
//     final electricController = Get.put(ElectricInfoGetX());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(Icons.arrow_back),
//           color: Colors.grey,
//         ),
//         actions: [],
//       ),
//       body: Obx(
//         () => Container(
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 30,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             manageController.tab.value = 0;
//                           },
//                           child: Container(
//                             color: manageController.tab.value == 0
//                                 ? Colors.lightGreen
//                                 : Colors.white,
//                             child: Center(
//                               child: Text(
//                                 '전력관리',
//                                 style: TextStyle(
//                                   fontSize:
//                                       manageController.tab.value == 0 ? 16 : 14,
//                                   fontWeight: manageController.tab.value == 0
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             manageController.tab.value = 1;
//                           },
//                           child: Container(
//                             color: manageController.tab.value == 1
//                                 ? Colors.lightGreen
//                                 : Colors.white,
//                             child: Center(
//                               child: Text(
//                                 '물품관리',
//                                 style: TextStyle(
//                                   fontSize:
//                                       manageController.tab.value == 1 ? 16 : 14,
//                                   fontWeight: manageController.tab.value == 1
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 manageController.tab.value == 0 ? electric() : item(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget item() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Container(),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 20),
//               child: InkWell(
//                 onTap: () {
//                   Get.to(() => AddBuyScreen());
//                 },
//                 child: Text(
//                   '+ 물품 추가',
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 20,
//           ),
//           itemCount: 10,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Expanded(
//                     child: FittedBox(
//                       fit: BoxFit.cover,
//                       child: CachedNetworkImage(
//                           imageUrl:
//                               'http://img.danawa.com/prod_img/500000/232/101/img/2101232_1.jpg?shrink=360:360&_v=20200221134654'),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     '장작',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     '2000원',
//                     style: TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }

//   Widget electric() {
//     final electricController = Get.put(ElectricInfoGetX());
//     final homePageController = Get.put(homePageGetX());

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Container(),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 20),
//               child: InkWell(
//                 onTap: () {
//                   Get.to(() => AddCategoryScreen());
//                 },
//                 child: Text(
//                   '+ 카테고리 추가',
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 20),
//               child: InkWell(
//                 onTap: () {
//                   Get.to(() => AddDeviceScreen());
//                 },
//                 child: Text(
//                   '+디바이스 추가',
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 10),
//               child: IconButton(
//                 onPressed: () {
//                   electricController.apiElectricCategoryList();
//                 },
//                 icon: Icon(
//                   Icons.refresh,
//                   color: const Color(0xff999999),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Column(
//           // 카테고리 타일 동적 생성
//           children: List<Widget>.generate(
//             electricController.detailData.value == null
//                 ? 0
//                 : electricController.detailData.value?.length,
//             (index) => Container(
//               margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: ExpansionTile(
//                 iconColor: const Color(0xff0abf52),
//                 textColor: Colors.black,
//                 initiallyExpanded: false,
//                 backgroundColor: Colors.white,
//                 leading: Container(
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: CachedNetworkImage(
//                       imageBuilder: (context, imageProvider) => Container(
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.16),
//                               spreadRadius: 2,
//                               blurRadius: 6,
//                               offset: Offset(6, 3),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(15),
//                           image: DecorationImage(
//                               image: imageProvider, fit: BoxFit.cover),
//                         ),
//                       ),
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                       imageUrl:
//                           'https://assets.gadgets360cdn.com/img/crypto/dogecoin-og-logo.png',
//                     ),
//                   ),
//                 ),
//                 title: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         electricController.detailData.value[index]['name'],
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       electricController
//                               .detailData.value[index]['deviceList'].length
//                               .toString() +
//                           '개',
//                       style: TextStyle(
//                           color: const Color(0xff999999), fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 // 디바이스 타일 동적 생성
//                 children: List<Widget>.generate(
//                   electricController.detailData.value[index]['deviceList'] ==
//                           null
//                       ? 0
//                       : electricController
//                           .detailData.value[index]['deviceList']?.length,
//                   (deviceIndex) => InkWell(
//                     onTap: () {
//                       graph_Controller.deviceId = electricController.detailData
//                           .value[index]['deviceList'][deviceIndex]['id'];
//                       graph_Controller.categoryId =
//                           electricController.detailData.value[index]['id'];
//                       graph_Controller.campId =
//                           homePageController.selectedCampId;
//                       Get.to(() => ElectricInfoScreen());
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           left: 10, right: 10, top: 5, bottom: 5),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 3,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Container(
//                         height: 60,
//                         margin: EdgeInsets.only(left: 20),
//                         child: Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Text(
//                                 electricController.detailData.value[index]
//                                     ['deviceList'][deviceIndex]['name'],
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: const Color(0xff707070),
//                                     shadows: [
//                                       Shadow(
//                                         blurRadius: 10,
//                                         color: Colors.grey,
//                                         offset: Offset(0, 3),
//                                       )
//                                     ]),
//                               ),
//                             ),
//                             Text(
//                               electricController
//                                       .detailData
//                                       .value[index]['deviceList'][deviceIndex]
//                                           ['usage']
//                                       .toString() +
//                                   'kW',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: const Color(0xff999999),
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 10,
//                                     color: Colors.grey,
//                                     offset: Offset(0, 3),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             CupertinoSwitch(
//                                 value: electricController.detailData
//                                                 .value[index]['deviceList']
//                                             [deviceIndex]['state'] ==
//                                         1
//                                     ? true
//                                     : false,
//                                 onChanged: (value) {
//                                   print("now: " +
//                                       electricController
//                                           .detailData
//                                           .value[index]['deviceList']
//                                               [deviceIndex]['state']
//                                           .toString());
//                                   electricController.apichangeStatus(
//                                       value,
//                                       electricController.detailData.value[index]
//                                           ['deviceList'][deviceIndex]['id']);
//                                 })
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }
