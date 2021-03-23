import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ErrorSnackBar extends StatelessWidget {
  final String msg;
  final bool show;

  ErrorSnackBar(this.show, this.msg);

  @override
  Widget build(BuildContext context) {
    if (show) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)));
      });
    }
    return Container(
      width: 0,
      height: 0,
    );
  }
}
