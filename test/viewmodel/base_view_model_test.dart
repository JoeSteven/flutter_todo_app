import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/frontend/viewmodel/base_view_model.dart';

import 'test_notify_call.dart';

class TestViewModel extends BaseViewModel {
  var count = 0;

  Future<void> addCount() async {
    sleep(Duration(seconds: 3));
    ++count;
  }
}

void main() {
  late TestViewModel _vm;
  setUpAll(() {
    _vm = TestViewModel();
  });

  tearDownAll(() {
    _vm.dispose();
  });

  test("Test request success", () async {
    final future = Future.value("success");
    final result = await testNotifyListenerCalls(
        _vm, () => _vm.futureRequest(future), 2, (count) {
      if (count == 0) {
        // loading
        expect(_vm.viewState.state, UIState.LOADING);
      } else if (count == 1) {
        expect(_vm.viewState.state, UIState.SUCCESS);
      }
    });
    expect("success", result);
  });

  test("Test request error", () async {
    final future = Future.error("error");
    final result = await testNotifyListenerCalls(
        _vm, () => _vm.futureRequest(future), 2, (count) {
      if (count == 0) {
        // loading
        expect(_vm.viewState.state, UIState.LOADING);
      } else if (count == 1) {
        expect(_vm.viewState.state, UIState.ERROR);
      }
    });
    expect(null, result);
  });

  test("Test safe request", () async {
    _vm.safeAsync("key1", () async {await _vm.addCount();});
    _vm.safeAsync("key2", () async {await _vm.addCount();});
    _vm.safeAsync("key1", () async {await _vm.addCount();});
    _vm.safeAsync("key1", () async {await _vm.addCount();});
    expect(_vm.count, 2);
  });
}
