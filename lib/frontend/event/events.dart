import 'package:flutter_todo_app/backend/entity/todo_task.dart';

class TodoTaskEvent {
  final TodoTask task;

  TodoTaskEvent(this.task);
}

class TodoTaskInsertEvent extends TodoTaskEvent {
  TodoTaskInsertEvent(TodoTask task) : super(task);
}

class TodoTaskUpdateEvent extends TodoTaskEvent {
  TodoTaskUpdateEvent(TodoTask task) : super(task);
}

class TodoTaskDeleteEvent extends TodoTaskEvent {
  TodoTaskDeleteEvent(TodoTask task) : super(task);
}