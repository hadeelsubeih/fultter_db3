import 'package:flutter/material.dart';
import 'package:fultter_db3/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NoteKeeper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        home: Home());
  }
}
