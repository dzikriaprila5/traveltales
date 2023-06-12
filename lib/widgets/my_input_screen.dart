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
  String? imageId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      imageId = args['imageId'] as String?;
      _titleController.text = args['title'] as String;
      _storyController.text = args['story'] as String;
    }
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _storyController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      if (imageId != null) {
        Provider.of<ImageFile>(context, listen: false).updateImage(
          imageId!,
          _titleController.text,
          _storyController.text,
          savedImage!,
        );
      } else {
        Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleController.text,
          _storyController.text,
          savedImage!,
        );
      }
      Navigator.pop(context);
    }
  }

  void onImageSave(File image) {
    setState(() {
      savedImage = image;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: onSave,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _storyController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 30),
              ImageInput(onImageSave),
            ],
          ),
        ),
      ),
    );
  }
}
