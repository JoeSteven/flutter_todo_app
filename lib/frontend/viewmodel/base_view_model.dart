import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';

abstract class BaseViewModel extends ChangeNotifier {
  HashMap<String, bool?> _inRequests = HashMap();
  ViewState _viewState = ViewState(UIState.EMPTY);

  ViewState get viewState => _viewState;

  Future<T?> futureRequest<T>(
    Future<T?> future, {
    bool handleError = true,
    String loadingMsg = "",
  }) async {
    setNewState(loading(msg: loadingMsg));
    try {
      setNewState(success());
      return await future;
    } catch (e) {
      setNewState(error(msg: e.toString()));
      if (!handleError){
        throw e;
      } else {
        return Future.value(null);
      }
    }
  }

  void safeAsync(String key, Function() request ) async{
    if (_inRequests[key] != null) return;
    _inRequests[key] = true;
    await request();
    _inRequests.remove(key);
  }

  void notify(void setData()) {
    setData();
    notifyListeners();
  }


  void setNewState(ViewState newState) {
    if (_viewState.state == newState.state && _viewState.msg == newState.msg)
      return;
    notify(() {
      _viewState = newState;
    });
  }

  ViewState empty({String msg = ""}) {
    return ViewState(UIState.EMPTY, msg: msg);
  }

  ViewState loading({String msg = ""}) {
    return ViewState(UIState.LOADING, msg: msg);
  }

  ViewState success({String msg = ""}) {
    return ViewState(UIState.SUCCESS, msg: msg);
  }

  ViewState error({String msg = ""}) {
    return ViewState(UIState.ERROR, msg: msg);
  }
}

class ViewState {
  final UIState state;
  final String msg;

  ViewState(this.state, {this.msg = ""});
}

enum UIState {
  EMPTY,
  LOADING,
  SUCCESS,
  ERROR,
}
