import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function(File) onImageSave;
  ImageInput(this.onImageSave);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = path.join(appDir.path, fileName);
    await _imageFile!.copy(saveImagePath);

    widget.onImageSave(File(saveImagePath));
  }

  Future<void> _galleryPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = path.join(appDir.path, fileName);
    await _imageFile!.copy(saveImagePath);

    widget.onImageSave(File(saveImagePath));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.deepOrange),
          ),
          child: _imageFile != null && _imageFile!.existsSync()
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                )
              : Center(child: Text('No image added')),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _galleryPicture,
              icon: Icon(Icons.image),
              label: Text('Add your image'),
            ),
            TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera),
              label: Text('Take a Picture'),
            ),
          ],
        ),
      ],
    );
  }
}
