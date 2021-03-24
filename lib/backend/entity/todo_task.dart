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

  @override
  bool operator ==(Object other) {
    return (other is TodoTask) && other.id == this.id;
  }

  @override
  int get hashCode => id.hashCode;

  bool sameInfo(TodoTask other) {
    return other.isFinished == this.isFinished &&
        other.title == this.title &&
        other.id == this.id;
  }

  int compareTo(TodoTask second) {
    if (isFinished && !second.isFinished) {
      return 1;
    } else if (!isFinished && second.isFinished) {
      return -1;
    } else {
      return id > second.id ? 1 : -1;
    }
  }
}
