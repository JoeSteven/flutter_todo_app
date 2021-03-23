class Dimen {
  static Dimen? _dimen;
  Dimen._internal();
  factory Dimen() {
    if (_dimen == null) _dimen = Dimen._internal();
    return _dimen!;
  }

  double set(double size) {
    // 可以统一处理转换
    return size;
  }

}