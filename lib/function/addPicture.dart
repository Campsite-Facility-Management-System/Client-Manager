import 'package:client_manager/screen/campManagement/addCampScreen.dart';
import 'package:client_manager/screen/campManagement/addCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPicture extends StatefulWidget {
  final double width, height;
  final int index;
  final int type;
  const AddPicture(this.width, this.height, this.index, this.type);

  @override
  AddPictureState createState() => AddPictureState();
}

class AddPictureState extends State<AddPicture> {
  File _image;
  final addCamp = new AddCampScreenState();
  final addCategory = new AddCategoryScreenState();

  getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('no image');
      }
    });

    //camp=1, category=2
    if (widget.type == 1) {
      addCamp.getimage(_image.path, widget.index);
    } else if (widget.type == 2) {
      addCategory.getimage(_image.path, widget.index);
    }

    // print("imagePath: " + _image.path);
  }

  showImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('갤러리'),
                    onTap: () {
                      getImage();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('카메라'),
                    onTap: () {
                      getImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showImage(context),
      child: _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                _image,
                fit: BoxFit.fitHeight,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              width: widget.width,
              height: widget.height,
              child: Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
    );
  }
}