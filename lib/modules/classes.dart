import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'database.dart';

class MyImage {
  final String id;
  final String title;
  final String story;
  final File image;

  MyImage({
    required this.id,
    required this.title,
    required this.story,
    required this.image,
  });
}

class ImageFile with ChangeNotifier {
  List<MyImage> _items = [];

  List<MyImage> get items {
    return [..._items];
  }

  Future<void> addImagePlace(String title, String story, File image) async {
    final newImage = MyImage(
      id: DateTime.now().toString(),
      title: title,
      story: story,
      image: image,
    );

    _items.add(newImage);
    notifyListeners();
    await DataHelper.insert('user_image', {
      'id': newImage.id,
      'title': newImage.title,
      'image': newImage.image.path,
      'story': newImage.story,
    });
  }

  MyImage findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fetchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list
        .map(
          (item) => MyImage(
            id: item['id'] as String,
            title: item['title'] as String,
            story: item['story'] as String,
            image: File(item['image'] as String),
          ),
        )
        .toList();
    notifyListeners();
  }

  void updateImage(
      String imageId, String title, String story, File image) async {
    final existingImageIndex =
        _items.indexWhere((image) => image.id == imageId);
    if (existingImageIndex >= 0) {
      final updatedImage = MyImage(
        id: imageId,
        title: title,
        story: story,
        image: image,
      );
      _items[existingImageIndex] = updatedImage;
      notifyListeners();
      await DataHelper.update('user_image', imageId, {
        'title': updatedImage.title,
        'image': updatedImage.image.path,
        'story': updatedImage.story,
      });
    }
  }

  void deleteImage(String imageId) async {
    _items.removeWhere((image) => image.id == imageId);
    notifyListeners();
    await DataHelper.delete('user_image', imageId);
  }
}
