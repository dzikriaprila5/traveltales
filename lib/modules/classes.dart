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
      'story': newImage.story,
      'image': newImage.image.path,
      'title': newImage.title,
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
            image: File(item['image']),
            title: item['title'],
            id: item['id'],
            story: item['story'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
