import 'package:flutter/material.dart';
import 'package:fultter_db3/chechbox.dart';
import 'package:fultter_db3/todo.dart';

class TaskList extends StatelessWidget {
  final List<Todo> tasks;

  TaskList({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks(),
    );
  }

  List<Widget> getChildrenTasks() {
    return tasks.map((todo) => Task(task: todo)).toList();
  }
}
