import 'package:flutter/material.dart';
import 'package:fultter_db3/addtodo.dart';
import 'package:fultter_db3/dbhelper.dart';
import 'package:fultter_db3/todo.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;
  bool isComplete;
  @override
  void initState() {
    isComplete = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Todo(isComplete: false, name: ''), 'Add ');
        },
        tooltip: 'Add ',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onTap: () {
                _delete(context, todoList[position]);
              },
            ),
            title: Center(
                child: Text(
              this.todoList[position].title,
            )),
            trailing: Checkbox(
                value: isComplete,
                activeColor: Colors.red,
                onChanged: (bool newValue) {
                  setState(() {
                    isComplete = newValue;
                  });
                }),
            onTap: () {
              navigateToDetail(this.todoList[position], 'Edit ');
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTodo(todo, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}
