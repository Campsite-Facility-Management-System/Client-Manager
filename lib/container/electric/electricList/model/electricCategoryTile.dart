import 'package:flutter/material.dart';

import '../electricDeviceList.dart';

class ElectricCategoryTile {
  static Widget buildTile(context, item) => Container(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item['name'],
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: ElectricDeviceList(item['deviceList']),
              )
            ],
          ),
        ),
      );
}
