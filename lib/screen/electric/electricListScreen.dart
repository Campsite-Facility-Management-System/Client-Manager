// import 'package:client_manager/container/electric/electricList/model/electricCategoryTile.dart';
// import 'package:client_manager/getX/electric/electricGraphGetX.dart';
// import 'package:client_manager/getX/electric/electricListGetX.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';

// class ElectricListScreen extends StatelessWidget {
//   var selectedcampName;
//   var selectedIndex;
//   var selectedId;
//   var campId;
//   bool refreshListener = false;
//   final token = new FlutterSecureStorage();
//   List<String> campNameList = [];
//   List<String> campIdList = [];

//   @override
//   Widget build(BuildContext context) {
//     final infoController = Get.put(ElectricInfoGetX());
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: EdgeInsets.only(left: 10),
//                     child: Obx(
//                       () => DropdownButton(
//                         value: infoController.selectedCampName.value,
//                         items: infoController.campNameList.map(
//                           (value) {
//                             return DropdownMenuItem(
//                               value: value,
//                               child: Text(
//                                 value,
//                                 style: TextStyle(fontSize: 24),
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         onChanged: (value) {
//                           infoController.setSelectedCampName(value);
//                           selectedIndex =
//                               infoController.campNameList.indexOf(value);
//                           infoController.setSelectedCampId(
//                               infoController.campIdList[selectedIndex]);
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 RaisedButton(
//                   child: Text('새로고침'),
//                   onPressed: () => {infoController.apiElectricCategoryList()},
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 height: 650,
//                 child: Obx(
//                   () => ListView.builder(
//                     itemCount: infoController.detailData.value == null
//                         ? 0
//                         : infoController.detailData.value?.length,
//                     itemBuilder: (context, index) {
//                       return ElectricCategoryTile.buildTile(
//                           context, infoController.detailData.value[index]);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
