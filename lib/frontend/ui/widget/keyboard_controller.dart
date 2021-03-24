import 'package:flutter/widgets.dart';

mixin KeyboardController {
  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}