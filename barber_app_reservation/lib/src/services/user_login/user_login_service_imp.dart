// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber_app_reservation/src/core/Exceptions/auth_exception.dart';
import 'package:barber_app_reservation/src/core/Exceptions/service_exception.dart';
import 'package:barber_app_reservation/src/core/constants/local_storage_keys.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/fp/nil.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImp implements UserLoginService {
  final UserRepository userRepository;
  UserLoginServiceImp({
    required this.userRepository,
  });

  /// pattern matching https://dart.dev/language/patterns#matching
  /// com essa arqutetura podemos validar todos os tipos de erros na camada atual
  /// o retono em caso de sucesso é nil pois em fp(functional programing) sempre devemos ter um erro e nunca pode ser null
  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    /// não é necessário tryCath aqui pois o userRepository ja lida com isso.
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final acessToken):
        final storage = await SharedPreferences.getInstance();
        storage.setString(LocalStorageKeys.acessToken, acessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() => Failure(ServiceException(
              message: 'Erro ao fazer login, tente novamente.')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Login ou senha inválidos'))
        };
    }
  }
}
