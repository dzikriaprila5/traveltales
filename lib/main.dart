import 'package:flutter/material.dart';
import 'screen/my_home_page.dart';
import 'widgets/my_input_screen.dart';
import 'package:provider/provider.dart';
import 'modules/classes.dart';
import 'screen/details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ImageFile(),
      child: MaterialApp(
        title: 'TravelTales',
        theme: ThemeData.dark(),
        home: MyHomePage(),
        routes: {
          MyInputScreen.routeName: (ctx) => MyInputScreen(),
          DetailesScreen.routeName: (ctx) => DetailesScreen(),
        },
      ),
    );
  }
}
