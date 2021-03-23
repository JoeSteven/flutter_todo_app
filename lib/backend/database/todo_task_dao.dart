import 'package:floor/floor.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';

@dao
abstract class TodoTaskDao {
  @Insert()
  Future<int> insertTask(TodoTask task);

  @Update()
  Future<int> updateTask(TodoTask task);

  @delete
  Future<int> deleteTask(TodoTask task);

  @Query('SELECT * FROM TodoTask')
  Future<List<TodoTask>> findAll();
}
