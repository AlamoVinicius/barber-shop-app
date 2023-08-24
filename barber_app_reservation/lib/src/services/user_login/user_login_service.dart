import 'package:barber_app_reservation/src/core/Exceptions/service_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
