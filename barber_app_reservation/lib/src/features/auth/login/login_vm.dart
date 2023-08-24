import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:barber_app_reservation/src/core/Exceptions/service_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/providers/application_providers.dart';
import 'package:barber_app_reservation/src/features/auth/login/login_state.dart';
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
        // TODO buscar dados do usuário logado
        // TODO analise para qual tipo de login
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
