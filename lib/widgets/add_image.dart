import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    _pickedFile =
        (await _picker.pickImage(source: ImageSource.gallery)) as PickedFile?;

    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("image upload")),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(35),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                child: Text("select an image"),
                onTap: () => _pickImage(),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: _pickedFile != null
                  ? Image.file(
                      File(_pickedFile!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Text("no image selected"),
            )
          ],
        ),
      )),
    );
  }
}
