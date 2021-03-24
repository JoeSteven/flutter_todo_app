import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/backend/entity/todo_task.dart';
import 'package:flutter_todo_app/frontend/ui/page/componnent/controller/switch_offstage_component_controller.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/ui/widget/confirm_widget.dart';
import 'package:flutter_todo_app/frontend/ui/widget/error_snack_bar.dart';
import 'package:flutter_todo_app/frontend/ui/widget/input_confirm_widget.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:provider/provider.dart';

class DeleteTaskComponent extends StatelessWidget {
  final SwitchOffStageComponentController<TodoTask> controller;

  DeleteTaskComponent(this.controller);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeleteTaskViewModel>(builder: (_, viewModel, __) {
      controller.setOnShowUpCallback((task) => viewModel.selectTask(task))
        ..setOnHideCallback(() => viewModel.setDisplay(false));
      return Stack(
        children: [
          Offstage(
            offstage: !viewModel.display,
            child: ConfirmWidget(
              StringRes().deleteTaskTitle,
              (isConfirm) => viewModel.deleteTask(viewModel.selectedTask!,
                  cancel: !isConfirm),
            ),
          ),
          ErrorSnackBar(viewModel.viewState.state == UIState.ERROR,
              viewModel.viewState.msg)
        ],
      );
    });
  }
}
