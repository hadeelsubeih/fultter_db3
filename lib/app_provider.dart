import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fultter_db3/todo.dart';

class AppProvider extends ChangeNotifier {
  final List<Todo> _tasks = [];

  UnmodifiableListView<Todo> get allTasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<Todo> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((todo) => !todo.isComplete));
  UnmodifiableListView<Todo> get completedTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.isComplete));

  void addTodo(Todo task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTodo(Todo task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Todo task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
