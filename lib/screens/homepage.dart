import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/data/database.dart';
import 'package:task/utils/todo_tile.dart';

import '../utils/add_new_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 241, 255),
      appBar: AppBar(
        title: const Text("TO DO"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskname: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask,
              );
            },
          ),
          const AddNewTask(),
        ],
      ),
    );
  }
}
