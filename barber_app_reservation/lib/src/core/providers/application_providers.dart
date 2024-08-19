import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/restClient/rest_client.dart';
import 'package:barber_app_reservation/src/core/ui/barbershop_nav_global_key.dart';
import 'package:barber_app_reservation/src/model/barbershop_model.dart';
import 'package:barber_app_reservation/src/model/user_model.dart';
import 'package:barber_app_reservation/src/repositories/barbershop/barbershop_repository.dart';
import 'package:barber_app_reservation/src/repositories/barbershop/barbershop_repository_imp.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository.dart';
import 'package:barber_app_reservation/src/repositories/user/user_repository_imp.dart';
import 'package:barber_app_reservation/src/services/user_login/user_login_service.dart';
import 'package:barber_app_reservation/src/services/user_login/user_login_service_imp.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_providers.g.dart';

//provedores singletons
@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(
      restClient: ref.read(restClientProvider),
    );

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImp(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  // com riverpod existe o cache sendo desnecessário fazer a injeção dos dados em um singleton usando o keepAlive = true
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImp(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);

  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch (result) {
    Success(value: final barbeshop) => barbeshop,
    Failure(:final exception) => throw exception
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();
  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);

  Navigator.of(BarbershopNavGlobalKey.instance.navkey.currentContext!)
      .pushNamedAndRemoveUntil('/auth/login', (route) => false);
}
