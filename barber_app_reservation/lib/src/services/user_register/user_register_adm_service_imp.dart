// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber_app_reservation/src/core/Exceptions/service_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/fp/nil.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository.dart';

import '../user_login/user_login_service.dart';
import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImp implements UserRegisterAdmService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  UserRegisterAdmServiceImp({
    required this.userRepository,
    required this.userLoginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await userRepository.registerAdmin(userData);

    switch (registerResult) {
      case Success():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
