import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
//reference our hive  box
  final _myBox = Hive.box('myBox');

  //run this method if it is first time ever opening this app

  //load the data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //update the database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
