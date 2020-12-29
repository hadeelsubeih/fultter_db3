import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _id;
  String name;
  bool isComplete;
  setValue(String name, bool isComplete) {
    this.isComplete = isComplete;
    this.name = name;
    this._id = _id;
    notifyListeners();
  }
}
