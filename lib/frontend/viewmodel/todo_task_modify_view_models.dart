import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';
import 'package:flutter_todo_app/frontend/event/events.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';

class AddTaskViewModel extends TodoRepoViewModel {
  AddTaskViewModel(TodoTaskRepo repo) : super(repo);

  void addTask(String title, {cancel = false}) {
    if (cancel) setNewState(success());
    safeAsync("addTask", () async {
      final result = await futureRequest(repo.insertTask(TodoTask(0, title)));
      // success fire insert event
      if (result != null) fireEvent(TodoTaskInsertEvent(result));
    });
  }
}

class UpdateTaskViewModel extends TodoRepoViewModel {
  UpdateTaskViewModel(TodoTaskRepo repo) : super(repo);

  void updateTask(TodoTask task,
      {String? newTitle, bool? newState, cancel = false}) {
    if (cancel) setNewState(success());
    safeAsync("updateTask", () async {
      final result = await futureRequest(repo.updateTask(task.update(
          title: newTitle ?? task.title,
          isFinished: newState ?? task.isFinished)));
      // success fire insert event
      if (result != null) fireEvent(TodoTaskUpdateEvent(result));
    });
  }
}

class DeleteTaskViewModel extends TodoRepoViewModel {
  DeleteTaskViewModel(TodoTaskRepo repo) : super(repo);

  void deleteTask(TodoTask task) {
    safeAsync("delete", () async {
      final result = await futureRequest(repo.deleteTask(task));
      if (result != null ) fireEvent(TodoTaskDeleteEvent(result));
    });
  }
}
