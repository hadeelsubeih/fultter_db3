import 'package:flutter/material.dart';
import 'package:fultter_db3/dbhelper.dart';
import 'package:fultter_db3/todo.dart';

class AddTodo extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;

  AddTodo(this.todo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return AddTodoState(this.todo, this.appBarTitle);
  }
}

class AddTodoState extends State<AddTodo> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Todo todo;

  TextEditingController titleController = TextEditingController();

  AddTodoState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.name;

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          move();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  move();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.amber,
                          textColor: Colors.white,
                          child: Text(
                            'ADD',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.amber,
                          textColor: Colors.black,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void move() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void _save() async {
    move();

    int result;
    if (todo.id != null) {
      result = await helper.updateTodo(todo);
    } else {
      result = await helper.insertTodo(todo);
    }

    if (result != 0) {
      _showAlertDialog('Status', ' Saved Successfully');
    } else {
      _showAlertDialog('Status', ' Not Saved Successfully');
    }
  }

  void _delete() async {
    move();

    if (todo.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    int result = await helper.deleteTodo(todo.id);
    if (result != 0) {
      _showAlertDialog('Status', ' Deleted Successfully');
    } else {
      _showAlertDialog('Status', ' Not Deleted Successfully');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
