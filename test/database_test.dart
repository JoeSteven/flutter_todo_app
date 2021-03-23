import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/backend/database/database.dart';
import 'package:flutter_todo_app/backend/database/todo_task_dao.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';

void main() {
  late AppDataBase _dataBase;
  late TodoTaskDao _taskDao;

  setUp(() async {
    _dataBase = await AppDataBase.testInstance();
    _taskDao = _dataBase.todoTaskDao;
  });

  tearDown(() async {
    await _dataBase.close();
  });

  Future<bool> prepareList() async {
    await _taskDao.insertTask(TodoTask(0, "test1"));
    await _taskDao.insertTask(TodoTask(0, "test2"));
    await _taskDao.insertTask(TodoTask(0, "test3"));
    return Future.value(true);
  }

  test(('Insert task in database'), () async{
      final id1 = await _taskDao.insertTask(TodoTask(0, "test"));
      expect(1, id1);
      final id2 = await _taskDao.insertTask(TodoTask(0, "test2"));
      expect(2, id2);
  });

  test(('get tasks in database'), () async{
    await prepareList();
    final taskList = await _taskDao.findAll();
    expect(true, taskList.length == 3);
  });

  test(('Update task in database'), () async{
    await prepareList();
    var taskList = await _taskDao.findAll();
    final updateTask = taskList[0].update(isFinished: true);
    final id = await _taskDao.updateTask(updateTask);
    taskList = await _taskDao.findAll();
    expect(true, id == taskList[0].id && taskList[0].isFinished);
  });

  test(('Delete task in database'), () async{
    await prepareList();
    var taskList = await _taskDao.findAll();
    expect(true, taskList.length == 3);
    final id = await _taskDao.deleteTask(taskList[0]);
    taskList = await _taskDao.findAll();
    expect(true, taskList.length == 2);
  });
}
