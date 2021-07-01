import 'package:flutter/material.dart';

class DeviceTile {
  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item['name'],
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text(
                  item['uuid'],
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      );
}
