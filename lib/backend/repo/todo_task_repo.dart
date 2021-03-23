import 'package:flutter_todo_app/backend/database/database.dart';
import 'package:flutter_todo_app/backend/database/todo_task_dao.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';

abstract class TodoTaskRepo {
  Future<List<TodoTask>> getAllTask();

  Future<TodoTask> updateTask(TodoTask task);

  Future<TodoTask> deleteTask(TodoTask task);

  Future<TodoTask> insertTask(TodoTask task);

  Future<void> close();
}

class TodoTaskRepoDelegate implements TodoTaskRepo {
  static TodoTaskRepoDelegate? _instance;
  String _dataBaseName = "";

  TodoTaskRepoDelegate._internal();

  factory TodoTaskRepoDelegate(String dataBaseName) {
    return _getInstance().._dataBaseName = dataBaseName;
  }

  static TodoTaskRepoDelegate _getInstance() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = TodoTaskRepoDelegate._internal();
    }
    return _instance!;
  }

  AppDataBase? _db;

  Future<TodoTaskDao> dao() async {
    if (_db == null) {
      _db = _dataBaseName == ":test:"
          ? await AppDataBase.testInstance()
          : await AppDataBase.instance(_dataBaseName);
    }
    return Future.value(_db!.todoTaskDao);
  }

  @override
  Future<List<TodoTask>> getAllTask() async {
    return (await dao()).findAll();
  }

  @override
  Future<TodoTask> deleteTask(TodoTask task) async {
    final id = await (await dao()).deleteTask(task);
    return id == task.id
        ? task
        : TodoTask(id, task.title, isFinished: task.isFinished);
  }

  @override
  Future<TodoTask> insertTask(TodoTask task) async {
    final id = await (await dao()).insertTask(task);
    return TodoTask(id, task.title, isFinished: task.isFinished);
  }

  @override
  Future<TodoTask> updateTask(TodoTask task) async {
    final id = await (await dao()).updateTask(task);
    return id == task.id
        ? task
        : TodoTask(id, task.title, isFinished: task.isFinished);
  }

  @override
  Future<void> close() async {
    return _db?.close();
  }
}
