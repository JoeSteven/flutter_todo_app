import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/repo_factory.dart';
import 'package:flutter_todo_app/frontend/ui/page/componnent/add_task_component.dart';
import 'package:flutter_todo_app/frontend/ui/page/componnent/edit_task_component.dart';
import 'package:flutter_todo_app/frontend/ui/page/componnent/todo_list_view_component.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';
import 'package:provider/provider.dart';

import 'componnent/delete_task_component.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }
}

class _TodoListState<TodoListPage> extends State {
  TodoTask? editTask;
  TodoTask? deleteTask;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
              value: TodoListViewModel(RepoFactory.todoTaskRepo)),
          ChangeNotifierProvider.value(
              value: AddTaskViewModel(RepoFactory.todoTaskRepo)),
          ChangeNotifierProvider.value(
              value: UpdateTaskViewModel(RepoFactory.todoTaskRepo)),
          ChangeNotifierProvider.value(
              value: DeleteTaskViewModel(RepoFactory.todoTaskRepo)),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(StringRes().todoListTitle),
          ),
          body: Stack(
            children: [
              TodoListComponent(),
              AddTaskComponent(),
              EditTaskComponent(),
              DeleteTaskComponent(),
            ],
          ),
          floatingActionButton:
              Consumer<AddTaskViewModel>(builder: (_, viewModel, __) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => viewModel.setDisplay(true),
            );
          }),
        ));
  }
}
