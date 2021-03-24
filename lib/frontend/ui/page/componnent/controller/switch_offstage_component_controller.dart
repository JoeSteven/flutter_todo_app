import 'dart:ui';

class SwitchOffStageComponentController<T> {
  void Function(T? data)? _onShowUp;
  VoidCallback? _onHide;
  void showUp(T? data) {
    if (_onShowUp != null) _onShowUp!(data);
  }

  void hide() {
    if (_onHide != null) _onHide!();
  }

  SwitchOffStageComponentController setOnShowUpCallback(void Function(T? task) onShowUp) {
    this._onShowUp = onShowUp;
    return this;
  }

  SwitchOffStageComponentController setOnHideCallback(VoidCallback? _onHide) {
    this._onHide = _onHide;
    return this;
  }
}