import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/frontend/ui/res/colors.dart';
import 'package:flutter_todo_app/frontend/ui/res/dimen.dart';
import 'package:flutter_todo_app/frontend/ui/res/string_res.dart';

class ConfirmWidget extends StatelessWidget {
  final String title;
  final Function(bool isConfirm) onConfirm;

  ConfirmWidget(
    this.title,
    this.onConfirm,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorRes().colorBgMask,
      child: Center(
        child: Container(
          height: Dimen().set(150),
          padding: EdgeInsets.all(Dimen().set(15)),
          margin: EdgeInsets.all(Dimen().set(15)),
          color: ColorRes().colorBgItem,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //title
              Text(title, style: TextStyle(fontSize: Dimen().set(16)),),
              // input
              Row(
                children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(Dimen().set(10)),
                          child: OutlinedButton(
                              onPressed: () => onConfirm(false),
                              child: Text(StringRes().btnCancel)))),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(Dimen().set(10)),
                          child: OutlinedButton(
                              onPressed: () => onConfirm(true),
                              child: Text(StringRes().btnConfirm)))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
