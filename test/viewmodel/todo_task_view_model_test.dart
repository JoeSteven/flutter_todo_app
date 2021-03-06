import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';

void main() {
  late TodoListViewModel _listViewModel;
  late AddTaskViewModel _addTaskViewModel;
  late UpdateTaskViewModel _updateTaskViewModel;
  late DeleteTaskViewModel _deleteTaskViewModel;
  setUpAll(() async {
    var repo = TodoTaskRepoDelegate(":test:");
    await repo.insertTask(TodoTask(0, "test0"));
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


  test("Test load task list, after load taskList should not be empty", () async {
    var i = 0;
    _listViewModel.addListener(() {
      if (i == 2) {
        print(_listViewModel.taskList);
        expect(_listViewModel.taskList.length, 2);
      }
      ++i;
    });
    _listViewModel.loadTasks();
  });

  test("Test switch task state and sort after task update", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.first.title, "test0");
    _listViewModel.switchTaskState(_listViewModel.taskList[0], true);
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.first.title, "test1");
    expect(_listViewModel.taskList.last.isFinished, true);
  });

  test("Test insert task list success", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    final oldLength = _listViewModel.taskList.length;
    _addTaskViewModel.setDisplay(true);
    _addTaskViewModel.addTask("test2");
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.length, oldLength + 1);
    expect(_addTaskViewModel.display, false);
  });

  test("Test insert task list cancel", () async {
    _addTaskViewModel.setDisplay(true);
    _addTaskViewModel.addTask("test2", cancel: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_addTaskViewModel.display, false);
  });

  test("Test update task list success", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    _updateTaskViewModel.setDisplay(true);
    _updateTaskViewModel.updateTask(_listViewModel.taskList[0],newTitle: "update1", newState: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.last.title, "update1");
    expect(_listViewModel.taskList.last.isFinished, true);
    expect(_updateTaskViewModel.display, false);
  });

  test("Test update task list cancel", () async {
    _updateTaskViewModel.setDisplay(true);
    _updateTaskViewModel.updateTask(TodoTask(0, "cancel"), cancel: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_updateTaskViewModel.display, false);
  });

  test("Test delete task list success", () async {
    _listViewModel.loadTasks();
    await Future.delayed(Duration(seconds: 1));
    final lastSize = _listViewModel.taskList.length;
    _deleteTaskViewModel.setDisplay(true);
    _deleteTaskViewModel.deleteTask(_listViewModel.taskList[0]);
    await Future.delayed(Duration(seconds: 1));
    expect(_listViewModel.taskList.length + 1, lastSize);
    expect(_deleteTaskViewModel.display, false);
  });

  test("Test delete task list cancel", () async {
    _deleteTaskViewModel.setDisplay(true);
    _deleteTaskViewModel.deleteTask(TodoTask(0, "cancel"), cancel: true);
    await Future.delayed(Duration(seconds: 1));
    expect(_deleteTaskViewModel.display, false);
  });

}
