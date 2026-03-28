import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'failures.dart';

class ErrorHandler implements Exception {
  static bool enableErrorToasts = kDebugMode;
  late Failure failure;

  ErrorHandler.handle(
    dynamic error, {
    bool showToast = true,
    StackTrace? stackTrace,
    BuildContext? context,
  }) {
    if (error is ErrorHandler) {
      failure = error.failure;
    } else if (error is DataSource) {
      failure = error.getFailure();
    } else if (error is Failure) {
      failure = error;
    } else {
      log(
        "Error: $error",
        error: error,
        stackTrace: stackTrace ?? StackTrace.current,
        name: "ErrorHandler",
      );
      failure = DataSource.defaultValue.getFailure();
    }

    if (enableErrorToasts && context != null && context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(failure.errorMessage),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultValue,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return const Failure(200, "Success");
      case DataSource.defaultValue:
      default:
        return const Failure(500, "Internal Server Error");
    }
  }
}
