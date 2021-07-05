import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'model/categoryTile.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CampDetailGetX());
    return Container(
      height: 650,
      child: GetBuilder<CampDetailGetX>(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.detailData == null
                ? 0
                : controller.detailData?.length,
            itemBuilder: (context, index) {
              return CategoryTile.buildTile(
                  context, controller.detailData[index]);
            },
          );
        },
      ),
    );
  }
}
