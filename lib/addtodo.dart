import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'todo.dart';

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
  bool isComplete = false;

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
                Checkbox(
                  value: isComplete,
                  onChanged: (value) {
                    this.isComplete = value;
                    setState(() {});
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(
                            'ADD',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddTodo(todo, appBarTitle),
                              ),
                            );
                            setState(() {
                              debugPrint("add");
                              _save();
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
      _showAlertDialog('Status', ' ADD Successfully');
    } else {
      _showAlertDialog('Status', ' Not ADD Successfully');
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
