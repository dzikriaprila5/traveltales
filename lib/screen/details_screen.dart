import 'package:flutter/material.dart';
import 'package:traveltales/modules/classes.dart';
import 'package:provider/provider.dart';
import 'package:traveltales/widgets/my_input_screen.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'DetailsScreen';

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)!.settings.arguments as String;
    final image =
        Provider.of<ImageFile>(context, listen: false).findImage(imageId);

    void _updateImage() async {
      final updatedData = await Navigator.of(context).pushNamed(
        MyInputScreen.routeName,
        arguments: {
          'imageId': image.id,
          'title': image.title,
          'story': image.story,
        },
      );
      if (updatedData != null) {
        final data = updatedData as Map<String, dynamic>;
        Provider.of<ImageFile>(context, listen: false).updateImage(
          data['imageId'] as String,
          data['title'] as String,
          data['story'] as String,
          image.image,
        );
      }
    }

    void _deleteImage() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Delete Image'),
          content: Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Provider.of<ImageFile>(context, listen: false)
                    .deleteImage(image.id);
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(image.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _updateImage,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteImage,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 400,
            width: double.infinity,
            child: Image.file(
              image.image,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            image.title,
            style: TextStyle(fontSize: 30.0),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            image.story,
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
