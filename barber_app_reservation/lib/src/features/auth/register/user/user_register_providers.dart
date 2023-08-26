import 'package:barber_app_reservation/src/core/providers/application_providers.dart';
import 'package:barber_app_reservation/src/services/user_register/user_register_adm_service.dart';
import 'package:barber_app_reservation/src/services/user_register/user_register_adm_service_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_providers.g.dart';

@riverpod
UserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) =>
    UserRegisterAdmServiceImp(
        userRepository: ref.watch(userRepositoryProvider),
        userLoginService: ref.watch(userLoginServiceProvider));
