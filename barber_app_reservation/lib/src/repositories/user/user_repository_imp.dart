import 'dart:developer';
import 'dart:io';

import 'package:barber_app_reservation/src/core/Exceptions/auth_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/restClient/rest_client.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    // syntaxe above is from dart 3.
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, stackTrace) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: stackTrace);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao fazer login', error: e, stackTrace: stackTrace);
      return Failure(
          AuthError(message: 'Erro ao fazer login, tente novamente.'));
    }
  }
}
