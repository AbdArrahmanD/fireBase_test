import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import './widgets/image_picker.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  File? imagePicked;
  void pickedImage(File? pickedImage) {
    imagePicked = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: UserImagePicker(pickedImage),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: savePicture,
        child: const Icon(Icons.upload_file),
      ),
    );
  }

  void savePicture() async {
    final ref =
        FirebaseStorage.instance.ref().child('usersImage').child('pic1.jpg');
    print('ref : $ref');
    await ref.putFile(imagePicked!);
    final imageUrl = await ref.getDownloadURL();
    print('imageUrl : $imageUrl');
  }
}
