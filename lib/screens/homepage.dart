import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/data/database.dart';
import 'package:task/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
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

  void createNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();
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
                deleteFunction: (context) => deleteTask(index),
              );
            },
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 55,
                  width: 280,
                  margin: const EdgeInsets.only(bottom: 18, left: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: "Add a new task",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 2, bottom: 10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        // print("clicked");
                        createNewTask();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 104, 1, 122),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
