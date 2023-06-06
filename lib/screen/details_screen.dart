import 'package:flutter/material.dart';
import 'package:traveltales/modules/classes.dart' as ima;
import 'package:provider/provider.dart';

class DetailesScreen extends StatelessWidget {
  static const routeName = 'DetailesScreen';

  const DetailesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)?.settings.arguments as String;
    final image =
        Provider.of<ima.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(
        title: Text(image.title),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
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
            image.title,
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}
