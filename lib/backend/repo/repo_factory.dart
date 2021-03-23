import 'package:flutter_todo_app/backend/repo/todo_task_repo.dart';

class RepoFactory {
  static TodoTaskRepo get todoTaskRepo {
    return TodoTaskRepoDelegate("app_database.db");
  }
}