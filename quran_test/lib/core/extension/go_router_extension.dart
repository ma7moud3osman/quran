import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on BuildContext {
  void pushToNamed(String name, {Object? extra}) {
    pushNamed(name, extra: extra);
  }

  void goToNamed(String name, {Object? extra}) {
    goNamed(name, extra: extra);
  }

  void popRoute() {
    if (canPop()) {
      pop();
    }
  }
}
