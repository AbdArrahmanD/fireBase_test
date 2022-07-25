import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class UserImagePicker extends StatefulWidget {
  final void Function(File? image) imageFun;
  const UserImagePicker(
    this.imageFun, {
    Key? key,
  }) : super(key: key);

  @override
  UserImagePickerState createState() => UserImagePickerState();
}

class UserImagePickerState extends State<UserImagePicker> {
  File? image;
  ImagePicker picker = ImagePicker();
  void chooseImage(ImageSource src) async {
    final pickedImageFile = await picker.pickImage(source: src);
    if (pickedImageFile != null) {
      setState(() {
        image = File(pickedImageFile.path);
      });
      widget.imageFun(image);
    } else {
      print('No Image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          backgroundImage: image != null ? FileImage(image!) : null,
          radius: 50,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => chooseImage(ImageSource.camera),
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Add Image\nFrom Camera',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: () => chooseImage(ImageSource.gallery),
              icon: Icon(
                Icons.image_outlined,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Add Image\nFrom Gallery',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
