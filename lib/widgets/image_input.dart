import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function selectedImage;

  const ImageInput(this.selectedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final _picker = ImagePicker();

  Future<void> _takePicture() async {
    final image = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      if (image != null) {
        _storedImage = File(image.path);
      } else {
        print('Image is empty');
      }
    });
    final tempDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await File(image.path).copy('${tempDir.path}/$fileName');
    widget.selectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image yet',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        FlatButton.icon(
            onPressed: () {
              _takePicture();
            },
            icon: Icon(Icons.camera_alt),
            label: Text('Add Image'))
      ],
    );
  }
}
