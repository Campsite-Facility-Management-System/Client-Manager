// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'model/electricDeviceTile.dart';

// class ElectricDeviceList extends StatefulWidget {
//   final deviceList;
//   const ElectricDeviceList(this.deviceList);

//   @override
//   ElectricDeviceListState createState() => ElectricDeviceListState();
// }

// class ElectricDeviceListState extends State<ElectricDeviceList> {
//   final token = new FlutterSecureStorage();
//   List deviceList = [];

//   @override
//   void initState() {
//     super.initState();
//     print(widget.deviceList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //     child: SizedBox(
//       //   height: 30,
//       // )
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: widget.deviceList == null ? 0 : widget.deviceList?.length,
//         itemBuilder: (context, index) {
//           // print("index: " + index.toString());
//           // print("list index: " + deviceList[index].toString());
//           return ElectricDeviceTile.buildTile(
//               context, widget.deviceList[index]);
//         },
//       ),
//     );
//   }
// }
