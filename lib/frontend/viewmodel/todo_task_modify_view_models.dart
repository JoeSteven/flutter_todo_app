import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';
import 'package:flutter_todo_app/frontend/event/events.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';

mixin SwitchVisibility on BaseViewModel {
  bool _display = false;

  bool get display => _display;

  void setDisplay(bool display) {
    notify(() {
      _display = display;
    });
  }
}

class AddTaskViewModel extends TodoRepoViewModel with SwitchVisibility {
  AddTaskViewModel(TodoTaskRepo repo) : super(repo);

  void addTask(String title, {cancel = false}) {
    if (cancel) {
      setDisplay(false);
      return;
    }
    if (title.isEmpty) {
      setNewState(error(msg: StringRes().errorEmptyInput));
      return;
    }
    safeAsync("addTask", () async {
      final result = await futureRequest(repo.insertTask(TodoTask(0, title)));
      // success fire insert event
      if (result != null) {
        fireEvent(TodoTaskInsertEvent(result));
        setDisplay(false);
      }
    });
  }
}

class UpdateTaskViewModel extends TodoRepoViewModel with SwitchVisibility {
  UpdateTaskViewModel(TodoTaskRepo repo) : super(repo);

  TodoTask? _selectedTask;
  TodoTask? get selectedTask => _selectedTask;

  @override
  bool get display => super.display && selectedTask != null;

  void selectTask(TodoTask? task) {
    if (task == null) return;
    _selectedTask = task;
    setDisplay(true);
  }

  void updateTask(TodoTask task, {String? newTitle, bool? newState, cancel = false}) {
    if (cancel) {
      setDisplay(false);
      return;
    }
    safeAsync("updateTask", () async {
      final result = await futureRequest(repo.updateTask(task.update(
          title: newTitle ?? task.title,
          isFinished: newState ?? task.isFinished)));
      // success fire insert event
      if (result != null) {
        fireEvent(TodoTaskUpdateEvent(result));
        setDisplay(false);
      }
    });
  }
}

class DeleteTaskViewModel extends TodoRepoViewModel with SwitchVisibility {
  DeleteTaskViewModel(TodoTaskRepo repo) : super(repo);
  TodoTask? _selectedTask;
  TodoTask? get selectedTask => _selectedTask;

  @override
  bool get display => super.display && selectedTask != null;

  void selectTask(TodoTask? task) {
    if (task == null) return;
    _selectedTask = task;
    setDisplay(true);
  }

  void deleteTask(TodoTask task,{cancel = false}) {
    if (cancel) {
      setDisplay(false);
      return;
    }
    safeAsync("delete", () async {
      final result = await futureRequest(repo.deleteTask(task));
      if (result != null) {
        fireEvent(TodoTaskDeleteEvent(result));
        setDisplay(false);
      }
    });
  }
}
