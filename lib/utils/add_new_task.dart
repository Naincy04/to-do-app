import 'package:flutter/material.dart';

import '../data/database.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  void createNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                backgroundColor: const Color.fromARGB(255, 168, 97, 180),
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
    );
  }
}
