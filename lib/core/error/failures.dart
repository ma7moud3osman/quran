import 'dart:convert';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int code;
  final String message;

  const Failure(this.code, this.message);

  String get errorMessage {
    try {
      final decodedMap = jsonDecode(message);
      if (decodedMap is Map && decodedMap.containsKey('message')) {
        return decodedMap['message'];
      }
      return message;
    } catch (e) {
      return message;
    }
  }

  @override
  List<Object?> get props => [message, code];
}
