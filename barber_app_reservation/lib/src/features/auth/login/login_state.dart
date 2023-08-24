// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  });

  // copy with padrão com imutabilidade
  LoginState copyWith({
    LoginStateStatus? status,
    // ValueGetter caso seja necessáio retornar o statdo para null no copyWith
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
