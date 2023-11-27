import 'package:flutter/material.dart';
import 'package:todo/task_modal.dart';
import 'package:todo/task_tile.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

List<Task> tasks = [];

class _listState extends State<list> {
  void toggleTaskState(int index, bool newState) {
    setState(() {
      tasks[index].isdone = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskTile(
              isChecked: tasks[index].isdone,
              taskTitle: tasks[index].name,
              toggleCheckboxState: (newState) {
                toggleTaskState(index, newState!);
              });
        });
  }
}
