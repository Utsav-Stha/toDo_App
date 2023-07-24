import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_practice/widgets/ToDo_tile.dart';
import 'package:web_practice/widgets/dialog_box.dart';
import '../database/database.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();
  //to control text in newly created task
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') != null) {
      db.loadData();
    }

    super.initState();
  }

  //checkbox  tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (ctx) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //to delete task
  deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 214, 214),
      appBar: AppBar(
        // backgroundColor: ,
        title: Text('TO DO'),
        centerTitle: true,
        elevation: 0,
      ),
      body: db.toDoList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 300,
                    child: Text(
                      'Make\nYour\nDay\nProductive\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              color: Theme.of(context).primaryColorLight,
                              offset: Offset(2.0, 2.0),
                            ),
                            Shadow(
                              color: Theme.of(context).primaryColorDark,
                              offset: Offset(-2.0, -2.0),
                            )
                          ]),
                    ),
                  ),
                  Text(
                    '\nEnter your First Task\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) => ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (p0) =>
                      checkBoxChanged(db.toDoList[index][1], index),
                  deleteFunction: ((p0) => deleteTask(index))),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        child: Icon(Icons.add),
      ),
    );
  }
}
