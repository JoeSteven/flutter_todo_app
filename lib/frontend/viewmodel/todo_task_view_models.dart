import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';
import 'package:flutter_todo_app/frontend/event/events.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';

abstract class TodoRepoViewModel extends BaseViewModel {
  final TodoTaskRepo repo;

  TodoRepoViewModel(this.repo);
}

class TodoListViewModel extends TodoRepoViewModel {
  List<TodoTask> _taskList = List.empty(growable: true);

  List<TodoTask> get taskList => _taskList;

  TodoListViewModel(TodoTaskRepo repo) : super(repo);

  @override
  void registerEventHere() {
    super.registerEventHere();
    // insert
    subscribeEvent<TodoTaskInsertEvent>((event) {
      _onInsert(event.task);
    });
    // update
    subscribeEvent<TodoTaskUpdateEvent>((event) {
      _onUpdate(event.task);
    });
    // delete
    subscribeEvent<TodoTaskDeleteEvent>((event) {
      _onDelete(event.task);
    });
  }

  void loadTasks() {
    safeAsync("loadTasks", () async {
      final result = await futureRequest(repo.getAllTask());
      if (result == null || result.isEmpty){
        setNewState(empty());
      }  else {
        notify(() => _taskList = result);
      }
    });
  }

  void _onInsert(TodoTask task) {
      if (_taskList.contains(task)) {
        _taskList[_taskList.indexOf(task)] = task;
      } else {
        _taskList.add(task);
      }
      notifyListeners();
  }

  void _onUpdate(TodoTask task) {
    if (!_taskList.contains(task)) return;
    _taskList[_taskList.indexOf(task)] = task;
    notifyListeners();
  }

  void _onDelete(TodoTask task) {
    _taskList.remove(task);
    notifyListeners();
  }
}
