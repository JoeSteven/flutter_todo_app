import 'dart:async';

import 'package:event_bus/event_bus.dart';

class AppEventBus {
  static EventBus? _bus;

  static EventBus get bus {
    if (_bus == null) _bus = EventBus();
    return _bus!;
  }
}

mixin EventFire {
  void fireEvent<T>(T event) {
    AppEventBus.bus.fire(event);
  }
}

mixin EventSubscriber {
  void registerEventHere();

  void subscribeEvent<T>(void onEvent(T event)) {
    autoDispose(AppEventBus.bus.on<T>().listen((event) {
      onEvent(event);
    }));
  }

  final List<StreamSubscription> _subscriptions = [];

  void autoDispose(StreamSubscription? subscription) {
    if (subscription == null) return;
    _subscriptions.add(subscription);
  }

  void cancelAllEvent() {
    for (StreamSubscription subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }
}