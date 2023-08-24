import 'package:barber_app_reservation/src/core/restClient/rest_client.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository_imp.dart';
import 'package:barber_app_reservation/src/services/user_login/user_login_service.dart';
import 'package:barber_app_reservation/src/services/user_login/user_login_service_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(
      restClient: ref.read(restClientProvider),
    );

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImp(userRepository: ref.read(userRepositoryProvider));
