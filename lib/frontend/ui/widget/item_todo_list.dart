import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/frontend/ui/res/dimen.dart';

class ItemTodoWidget extends StatelessWidget {
  final TodoTask task;
  final Function(bool check, TodoTask task) onChanged;
  final Function(TodoTask task) onDelete;
  final Function(TodoTask task) onEdit;

  ItemTodoWidget(this.task, this.onChanged, this.onDelete, this.onEdit);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: task.isFinished,
            onChanged: (check) => onChanged(check ?? false, task)),
        Expanded(child: Container(
            margin: EdgeInsets.only(
                left: Dimen().set(10), right: Dimen().set(10)),
            child:  Text(
                task.title,
                style: task.isFinished
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : TextStyle(),
              ),
        )),
        Container(
          margin: EdgeInsets.only(right: Dimen().set(10)),
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: ()=>onDelete(task),
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: ()=>onEdit(task),
        ),
      ],
    );
  }
}
