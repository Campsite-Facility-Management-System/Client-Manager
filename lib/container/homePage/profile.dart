import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_manager/function/env.dart';
import 'package:client_manager/container/homePage/model/myInfo.dart';
import 'package:client_manager/getX/homePage/homePageGetX.dart';
import 'package:client_manager/getX/token/tokenGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final token = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(homePageGetX());

    return Container(
      child: FutureBuilder<MyInfo>(
        future: controller.me(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 90,
                        child: ListTile(
                          title: new CachedNetworkImage(
                            imageBuilder: (BuildContext context,
                                ImageProvider imageProvider) {
                              return AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.black12),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            imageUrl: Env.url + snapshot.data.img_url,
                            placeholder: (context, url) => Container(
                              height: 50,
                              width: 50,
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data.nick != null
                                  ? snapshot.data.nick
                                  : 'null',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '포인트: ' +
                                  (snapshot.data.point != null
                                      ? snapshot.data.point
                                      : 'null') +
                                  ' Point',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.error_outline,
                  size: 50,
                ),
                Text('Error: ${snapshot.error}'),
              ],
            );
          } else {
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 50,
                  height: 50,
                ),
                Text('Loading...'),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
