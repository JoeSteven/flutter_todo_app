import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/frontend/ui/page/componnent/controller/switch_offstage_component_controller.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';
import 'package:flutter_todo_app/frontend/ui/widget/error_snack_bar.dart';
import 'package:flutter_todo_app/frontend/ui/widget/input_confirm_widget.dart';
import 'package:flutter_todo_app/frontend/ui/widget/keyboard_controller.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';
import 'package:flutter_todo_app/frontend/viewmodel/todo_task_modify_view_models.dart';
import 'package:provider/provider.dart';

class AddTaskComponent extends StatelessWidget with KeyboardController {
  final SwitchOffStageComponentController<dynamic> controller;

  AddTaskComponent(this.controller);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTaskViewModel>(builder: (_, viewModel, __) {
      controller.setOnShowUpCallback((_) => viewModel.setDisplay(true))
        ..setOnHideCallback(() => viewModel.setDisplay(false));
      if (!viewModel.display) closeKeyboard(context);
      return Stack(
        children: [
          Offstage(
            offstage: !viewModel.display,
            child: InputConfirmWidget(
              StringRes().addTaskTitle,
              (input) => viewModel.addTask(input),
              () => viewModel.addTask("", cancel: true),
              hint: StringRes().hintAddTask,
            ),
          ),
          ErrorSnackBar(viewModel.viewState.state == UIState.ERROR,
              viewModel.viewState.msg)
        ],
      );
    });
  }
}
