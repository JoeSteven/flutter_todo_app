import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';

void main() {
  late TodoListViewModel _listViewModel;
  late AddTaskViewModel _addTaskViewModel;
  late UpdateTaskViewModel _updateTaskViewModel;
  late DeleteTaskViewModel _deleteTaskViewModel;
  setUpAll(() async {
    var repo = TodoTaskRepoDelegate(":test:");
    await repo.insertTask(TodoTask(0, "test1"));
    _listViewModel = TodoListViewModel(repo);
    _addTaskViewModel = AddTaskViewModel(repo);
    _updateTaskViewModel = UpdateTaskViewModel(repo);
    _deleteTaskViewModel = DeleteTaskViewModel(repo);
  });

  tearDownAll(() {
    _listViewModel.dispose();
    _addTaskViewModel.dispose();
    _updateTaskViewModel.dispose();
    _deleteTaskViewModel.dispose();
  });


  test("Test load task list", () async {
    var i = 0;
    _listViewModel.addListener(() {
      if (i == 2) {
        print(_listViewModel.taskList);
        expect(_listViewModel.taskList.length, 1);
      }
      ++i;
    });
    _listViewModel.loadTasks();
  });

  test("Test insert task list success", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    _addTaskViewModel.addTask("test2");
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.last.title, "test2");
  });

  test("Test insert task list cancel", () async {
    _addTaskViewModel.addTask("test2", cancel: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_addTaskViewModel.viewState.state, UIState.SUCCESS);
  });

  test("Test update task list success", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    _updateTaskViewModel.updateTask(_listViewModel.taskList[0],newTitle: "update1", newState: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList[0].title, "update1");
    expect(_listViewModel.taskList[0].isFinished, true);
  });

  test("Test update task list cancel", () async {
    _updateTaskViewModel.updateTask(TodoTask(0, "cancel"), cancel: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_updateTaskViewModel.viewState.state, UIState.SUCCESS);
  });

  test("Test delete task list success", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    final lastSize = _listViewModel.taskList.length;
    _deleteTaskViewModel.deleteTask(_listViewModel.taskList[0]);
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.length + 1, lastSize);
  });

}
