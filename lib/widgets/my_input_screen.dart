import 'package:flutter/material.dart';
import 'package:traveltales/widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:traveltales/modules/classes.dart';

class MyInputScreen extends StatefulWidget {
  const MyInputScreen({Key? key}) : super(key: key);
  static const routeName = 'MyInputScreen';

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();

  File? savedImage;

  void onSave() {
    if (_titleController.text.isEmpty ||
        _storyController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleController.text, _storyController.text, savedImage!);
      Navigator.pop(context);
    }
  }

  void onImageSave(File image) {
    setState(() {
      savedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: onSave),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _storyController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 50),
              ImageInput(onImageSave),
            ],
          ),
        ),
      ),
    );
  }
}
