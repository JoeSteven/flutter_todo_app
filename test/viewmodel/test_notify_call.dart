import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Future<R?> testNotifyListenerCalls<T extends ChangeNotifier, R>(
    T notifier,
    Future<R> Function() testFunction,
    int notifyCount,
    void expectFunc(int count)) async {
  int i = 0;
  notifier.addListener(() {
    expectFunc(i);
    i++;
  });
  final R result = await testFunction();
  expect(i, notifyCount);
  return result;
}
