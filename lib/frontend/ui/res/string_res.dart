class StringRes {
  static StringRes? _strings;
  StringRes._internal();
  factory StringRes() {
    if (_strings == null) _strings = StringRes._internal();
    return _strings!;
  }

  // task list
  get todoListTitle => "待办事项";
  get emptyTodo => "暂无待办任务，请先添加吧";

  // add task
  get addTaskTitle => "新建待办";
  get hintAddTask => "输入待办任务";

  // edit task
  get editTaskTitle => "修改待办任务";

  // delete task
  get deleteTaskTitle => "确定要删除待办任务？";

  // common
  get btnDone => "完成";
  get btnConfirm => "确认";
  get btnCancel => "取消";

  get errorEmptyInput => "输入不能为空";
}