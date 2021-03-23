
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/ui/widget/error_snack_bar.dart';
import 'package:flutter_todo_app/frontend/ui/widget/item_todo_list.dart';
import 'package:flutter_todo_app/frontend/ui/widget/loading_widget.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_view_models.dart';
import 'package:provider/provider.dart';

class TodoListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<TodoListViewModel, UpdateTaskViewModel,
        DeleteTaskViewModel>(
        builder: (context, todoListVM, updateVM, deleteVM, _) {
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
                        (finished, task) =>
                        updateVM.updateTask(task, newState: finished),
                    // delete
                        (task) => deleteVM.selectTask(task),
                    // edit
                        (task) => updateVM.selectTask(task));
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