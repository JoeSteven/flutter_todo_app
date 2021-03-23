import 'package:flutter/material.dart';

class ColorRes {
  static ColorRes? _colorRes;

  ColorRes._internal();

  factory ColorRes() {
    if (_colorRes == null) _colorRes = ColorRes._internal();
    return _colorRes!;
  }

  get colorBgPage => Colors.grey;
  get colorBgItem => Colors.white;
  get colorBgMask => Colors.black45;
}