import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  final Function deleteFunction;

  ToDoTile({
    super.key,
    required this.taskname,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading:
              //checkbox
              Checkbox(value: taskCompleted, onChanged: onChanged),

          //task name
          title: Text(
            taskname,
            style: TextStyle(
              decoration: taskCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: Colors.red),
            child: const Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
