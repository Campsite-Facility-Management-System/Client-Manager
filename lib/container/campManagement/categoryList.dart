import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'model/categoryTile.dart';

class CategoryList extends StatefulWidget {
  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  final token = new FlutterSecureStorage();
  List<dynamic> categoryList;

  @override
  void initState() {
    super.initState();
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CampDetailGetX());
    // controller.apiCampDetail();
    return Container(
      height: 650,
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: GetBuilder<CampDetailGetX>(builder: (_) {
        return ListView.builder(
          // shrinkWrap: true,
          itemCount:
              controller.detailData == null ? 0 : controller.detailData?.length,
          itemBuilder: (context, index) {
            return CategoryTile.buildTile(
                context, controller.detailData[index]);
          },
        );
      }),
    );
  }
}
