import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:barber_app_reservation/src/core/Exceptions/service_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/providers/application_providers.dart';
import 'package:barber_app_reservation/src/features/auth/login/login_state.dart';
import 'package:barber_app_reservation/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    /// controlar o package asyncState sem a necessidade de usar no extend do future (manualmente)
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        //invalidate cache
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);
        final userModal = await ref.read(getMeProvider.future);
        switch (userModal) {
          case UserModelADM():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModeEmployee():
            state = state.copyWith(status: LoginStateStatus.employeLogin);
        }
        break;

      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandle.close();
  }
}
