import 'package:barber_app_reservation/src/core/Exceptions/auth_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/model/user_model.dart';

import '../../core/Exceptions/repository_exception.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();
}
