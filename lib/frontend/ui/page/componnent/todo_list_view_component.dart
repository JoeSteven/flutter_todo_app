
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/ui/widget/error_snack_bar.dart';
import 'package:flutter_todo_app/frontend/ui/widget/item_todo_list.dart';
import 'package:flutter_todo_app/frontend/ui/widget/loading_widget.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';
import 'package:provider/provider.dart';

class TodoListComponent extends StatelessWidget {
  late final Function(TodoTask task) onDelete;
  late final Function(TodoTask task) onUpdate;

  TodoListComponent({required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListViewModel>(
        builder: (context, todoListVM, _) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            todoListVM.loadTasks();
          });
          // return empty view
          var realWidget;
          if (todoListVM.taskList.isEmpty ||
              todoListVM.viewState.state == UIState.EMPTY) {
            realWidget = Center(
              child: Text(StringRes().emptyTodo),
            );
          } else {
            realWidget = ListView.builder(
              itemBuilder: (context, index) {
                return ItemTodoWidget(
                    todoListVM.taskList[index],
                    // switch check
                        (finished, task) => todoListVM.switchTaskState(task, finished),
                    // delete
                        (task) => onDelete(task),
                    // edit
                        (task) => onUpdate(task));
              },
              itemCount: todoListVM.taskList.length,
            );
          }
          return Stack(
            children: [
              realWidget,
              LoadingView(todoListVM.viewState.state == UIState.LOADING),
              ErrorSnackBar(todoListVM.viewState.state == UIState.ERROR,
                  todoListVM.viewState.msg)
            ],
          );
        });
  }

}