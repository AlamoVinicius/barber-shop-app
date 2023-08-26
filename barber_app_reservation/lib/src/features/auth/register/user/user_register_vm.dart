import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/providers/application_providers.dart';
import 'package:barber_app_reservation/src/features/auth/register/user/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_register_vm.g.dart';

enum UserRegisterStateStaus { intial, success, error }

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStaus build() => UserRegisterStateStaus.intial;

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);

    //records dart 3.0, com record não é mais necessário criar classes DTO
    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final registerResult =
        await userRegisterAdmService.execute(userData).asyncLoader();
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStaus.success;
      case Failure():
        state = UserRegisterStateStaus.error;
    }
  }
}
