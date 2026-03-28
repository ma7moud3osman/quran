import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on BuildContext {
  void goTo(String path, {Object? extra}) => go(path, extra: extra);

  void goToNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    /*
    if (_requiresAuth(name) && !_isAuthenticated()) {
      // showLoginRequiredSheet();
      return;
    }
    */
    goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<T?> pushTo<T extends Object?>(String path, {Object? extra}) =>
      push<T>(path, extra: extra);

  Future<T?> pushToNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    /*
    if (_requiresAuth(name) && !_isAuthenticated()) {
      // showLoginRequiredSheet();
      return Future.value(null);
    }
    */
    return GoRouter.of(this).pushNamed<T>(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<T?> replaceTo<T extends Object?>(String path, {Object? extra}) =>
      GoRouter.of(this).pushReplacement<T>(path, extra: extra);

  void replaceToNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    popRoute();
    GoRouter.of(this).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void popRoute<T extends Object?>([T? result]) =>
      GoRouter.of(this).pop(result);

  void popUntilNamed(String name) {
    Navigator.of(this).popUntil((route) => route.settings.name == name);
  }

  bool get canPopRoute => canPop();
}
