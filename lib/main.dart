import 'package:flutter/material.dart';
import 'package:web_practice/views/home_view.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();

  //open a box where box is database like a map
  await Hive.openBox('myBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeView(),
    );
  }
}
