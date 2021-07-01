import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/getX/campManagement/campDetailGetX.dart';
import 'package:client_manager/screen/campManagement/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CampTile {
  static final controller = Get.put(CampDetailGetX());

  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          // padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: new CachedNetworkImage(
                  imageBuilder:
                      (BuildContext context, ImageProvider imageProvider) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 0.5, color: Colors.black12),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    );
                  },
                  imageUrl: Env.url + item['img_url'],
                  placeholder: (context, url) => Container(
                    height: 50,
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              ListTile(
                title: Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  item['address'],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ListTile(
                title: RaisedButton(
                  color: Colors.green,
                  onPressed: () => {
                    controller.setSelectedCampId(item['id']),
                    controller.apiCampDetail(),
                    Get.to(CampDetailScreen()),
                  },
                  child: Text(
                    '관리',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
