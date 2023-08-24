import 'package:barber_app_reservation/src/core/Exceptions/auth_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
