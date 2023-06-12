import 'package:flutter/material.dart';
import 'package:traveltales/widgets/my_input_screen.dart';
import 'package:provider/provider.dart';
import 'package:traveltales/modules/classes.dart';
import 'details_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.pushNamed(context, MyInputScreen.routeName);
        },
        child: const Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text('My Journey'),
      ),
      body: FutureBuilder(
        future: Provider.of<ImageFile>(context, listen: false).fetchImage(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Consumer<ImageFile>(
            builder: (ctx, image, _) {
              if (image.items.isEmpty) {
                return Center(child: const Text('Start adding Your Story'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridTile(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: image.items[i].id,
                          );
                        },
                        child: Image.file(
                          image.items[i].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    footer: GridTileBar(
                      leading: Text(
                        image.items[i].title,
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      title: const Text(''),
                      subtitle: Text(image.items[i].id),
                    ),
                  ),
                ),
                itemCount: image.items.length,
              );
            },
          );
        },
      ),
    );
  }
}
