import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/frontend/ui/res/colors.dart';
import 'package:flutter_todo_app/frontend/ui/res/dimen.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';

class InputConfirmWidget extends StatelessWidget {
  final String title;
  final String? input;
  final String? hint;
  final Function(String text) onConfirm;
  final Function() onCancel;

  InputConfirmWidget(this.title, this.onConfirm, this.onCancel,
      {this.input, this.hint});

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();
    final inputDecoration =
        hint != null ? InputDecoration(hintText: hint) : InputDecoration();
    if (input != null) inputController.text = input!;
    return Container(
      color: ColorRes().colorBgMask,
      child: Center(
        child: Container(
          height: Dimen().set(200),
          margin: EdgeInsets.all(Dimen().set(15)),
          padding: EdgeInsets.all(Dimen().set(15)),
          color: ColorRes().colorBgItem,
          child: Column(
            children: [
              //title
              Text(title,style:TextStyle(fontSize: Dimen().set(16))),
              // input
              Container(
                margin: EdgeInsets.all(Dimen().set(10)),
                child: TextField(
                  controller: inputController,
                  decoration: inputDecoration,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(Dimen().set(10)),
                          child: OutlinedButton(
                              onPressed: () => onCancel(),
                              child: Text(StringRes().btnCancel)))),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(Dimen().set(10)),
                          child: OutlinedButton(
                              onPressed: () => onConfirm(inputController.text),
                              child: Text(StringRes().btnDone)))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
