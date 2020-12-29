import 'package:flutter/material.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:sqflite/sqlite_api.dart';

import 'addtodo.dart';
import 'dbhelper.dart';
import 'todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new Tabpar(User('hadeelsh', 'hadeelsh4@gmail.com')),
      title: new Text(
        'TODO',
        textScaleFactor: 2,
      ),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

// ignore: must_be_immutable
class Tabpar extends StatefulWidget {
  User user;
  Tabpar(this.user);
  @override
  _TabparState createState() => _TabparState();
}

class _TabparState extends State<Tabpar> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;

  bool isComplete;
  int count = 0;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              // ignore: missing_return
              builder: (context) {
                navigateToDetail(Todo(isComplete: true, name: ''), 'Add ');
              },
            ));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(widget.user.name[0].toUpperCase()),
              ),
              accountName: Text(widget.user.name),
              accountEmail: Text(widget.user.email),
            ),
            ListTile(
              onTap: () {
                tabController.animateTo(0);
                Navigator.pop(context);
              },
              title: Text('All Taske'),
              subtitle: Text('all taske'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                tabController.animateTo(1);
                Navigator.pop(context);
              },
              title: Text('Complete Taske'),
              //subtitle: Text('all taske'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                tabController.animateTo(2);
                Navigator.pop(context);
              },
              title: Text('InComplete Taske'),
              trailing: Icon(Icons.arrow_right),
            ),
          ],
        )),
        appBar: AppBar(
          title: Text("Todo"),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: 'All Taske',
              ),
              Tab(
                text: 'Complete Taske',
              ),
              Tab(
                text: 'InComplete Taske',
              ),
            ],
            isScrollable: true,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [AllTaske(), CompleteTaske(), InCompleteTaske()],
            )),
          ],
        ));
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
                activeColor: Colors.blue,
                onChanged: (bool newValue) {
                  setState(() {
                    isComplete = newValue;
                  });
                  // Text('Remember me');
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

// ignore: unused_element
void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  Scaffold.of(context).showSnackBar(snackBar);
}

class AllTaske extends StatefulWidget {
  @override
  _AllTaskeState createState() => _AllTaskeState();
}

class _AllTaskeState extends State<AllTaske> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(),
    );
  }
}

class CompleteTaske extends StatefulWidget {
  @override
  _CompleteTaskeState createState() => _CompleteTaskeState();
}

class _CompleteTaskeState extends State<CompleteTaske> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(),
    );
  }
}

class InCompleteTaske extends StatefulWidget {
  @override
  _InCompleteTaskeState createState() => _InCompleteTaskeState();
}

class _InCompleteTaskeState extends State<InCompleteTaske> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(),
    );
  }
}

class User {
  String name;
  String email;
  User(this.name, this.email);
}
