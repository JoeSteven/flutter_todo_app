import 'package:floor/floor.dart';

@entity
class TodoTask {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String title;

  bool isFinished;

  TodoTask(this.id, this.title, {this.isFinished = false});

  TodoTask update({String? title, bool? isFinished}) {
    return TodoTask(this.id, title ?? this.title,
        isFinished: isFinished ?? this.isFinished);
  }
}
