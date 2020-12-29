import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter_db3/app_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AppProvider();
      },
      child: MaterialApp(
        home: Screen1(),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        child: Consumer<AppProvider>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('my name is ${value.name}'),
              Text('my isComplete is ${value.isComplete}'),
              RaisedButton(onPressed: () {
                value.setValue('', true);
              })
            ],
          );
        }),
      ),
    );
  }
}
