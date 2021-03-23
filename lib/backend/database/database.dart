// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_todo_app/backend/database/todo_task_dao.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; //flutter packages pub run build_runner build

@Database(version: 1, entities: [TodoTask])
abstract class AppDataBase extends FloorDatabase {
  TodoTaskDao get todoTaskDao;

  static Future<AppDataBase> instance() {
    return $FloorAppDataBase.databaseBuilder('todo_app_databse.dp').build();
  }
}