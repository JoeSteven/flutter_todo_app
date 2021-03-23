import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';

void main() {
  late TodoTaskRepo _repo;

  setUpAll(() async{
    _repo = TodoTaskRepoDelegate(":test:");
  });

  tearDownAll(() async {
    await _repo.close();
  });

  Future<bool> prepareList() async {
    await _repo.insertTask(TodoTask(0, "test1"));
    await _repo.insertTask(TodoTask(0, "test2"));
    await _repo.insertTask(TodoTask(0, "test3"));
    return Future.value(true);
  }

  test(('Insert task in database'), () async{
    await prepareList();
    final todoTask1 = await _repo.insertTask(TodoTask(0, "test4"));
    expect("test4", todoTask1.title);
    final todoTask2 = await _repo.insertTask(TodoTask(0, "test5"));
    expect("test5", todoTask2.title);
  });

  test(('get tasks in database'), () async{
    final taskList = await _repo.getAllTask();
    expect(5, taskList.length);
  });

  test(('Update task in database'), () async{
    var taskList = await _repo.getAllTask();
    final updateTask = await _repo.updateTask(taskList[0].update(isFinished: true));
    expect(true, updateTask.isFinished && updateTask.title == "test1");
  });

  test(('Delete task in database'), () async{
    var taskList = await _repo.getAllTask();
    expect(5, taskList.length);
    final deleteTask = await _repo.deleteTask(taskList[0]);
    expect("test1", deleteTask.title);
    taskList = await _repo.getAllTask();
    expect(4, taskList.length);
  });
}