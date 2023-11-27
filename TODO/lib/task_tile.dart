import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo/global/global.dart';

bool isChecked = false;

class TaskTile extends StatefulWidget {
  bool isChecked = false;
  final String taskTitle;
  final Function(bool?) toggleCheckboxState;
  TaskTile({
    required this.isChecked,
    required this.taskTitle,
    required this.toggleCheckboxState,
  });
  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CheckboxWidget(
          isChecked: widget.isChecked,
          toggleCheckboxState: widget.toggleCheckboxState),
      title: Text(
        widget.taskTitle,
        style: TextStyle(
          color: const Color.fromARGB(255, 111, 133, 240),
          fontWeight: FontWeight.w700,
          decoration: widget.isChecked ? TextDecoration.lineThrough : null,
          decorationColor: Colors.red,
          decorationThickness: 3,
        ),
      ),
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  final bool isChecked;
  final Function(bool?) toggleCheckboxState;

  CheckboxWidget({required this.isChecked, required this.toggleCheckboxState});

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isChecked,
      onChanged: (newvalue) {
        widget.toggleCheckboxState(newvalue);
      },
    );
  }
}
