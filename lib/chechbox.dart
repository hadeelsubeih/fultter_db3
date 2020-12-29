import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_db3/todo.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  Todo todo;
  Function function;
  TaskWidget(this.todo, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () {}),
            Text(widget.todo.name),
            Checkbox(
                value: widget.todo.isComplete,
                onChanged: (value) {
                  this.widget.todo.isComplete = !this.widget.todo.isComplete;
                  setState(() {});
                  widget.function();
                })
          ],
        ),
      ),
    );
  }
}
