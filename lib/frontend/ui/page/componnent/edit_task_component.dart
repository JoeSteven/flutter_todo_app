import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/ui/widget/error_snack_bar.dart';
import 'package:flutter_todo_app/frontend/ui/widget/input_confirm_widget.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:provider/provider.dart';

class DeleteTaskComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateTaskViewModel>(builder: (_, viewModel, __) {
      return Stack(
        children: [
          Offstage(
            offstage: !viewModel.display,
            child: InputConfirmWidget(
              StringRes().editTaskTitle,
              (input) => viewModel.updateTask(viewModel.selectedTask!,
                  newTitle: input),
              () => viewModel.updateTask(TodoTask(0, ""), cancel: true),
              input: viewModel.selectedTask?.title,
            ),
          ),
          ErrorSnackBar(viewModel.viewState.state == UIState.ERROR,
              viewModel.viewState.msg)
        ],
      );
    });
  }
}
