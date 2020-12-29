import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_db3/app_provider.dart';
import 'package:fultter_db3/todo.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final Todo task;

  Task({@required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isComplete,
        onChanged: (bool checked) {
          Provider.of<AppProvider>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<AppProvider>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}
