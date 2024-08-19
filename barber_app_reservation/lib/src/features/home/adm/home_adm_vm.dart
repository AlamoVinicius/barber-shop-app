import 'package:asyncstate/asyncstate.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/providers/application_providers.dart';
import 'package:barber_app_reservation/src/features/home/adm/home_adm_state.dart';
import 'package:barber_app_reservation/src/model/barbershop_model.dart';
import 'package:barber_app_reservation/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.read(getMyBarbershopProvider.future);

    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getEmployees(barbershopId);

    switch (employeesResult) {
      case Success(value: final employeesData):
        final employess = <UserModel>[];

        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employess.add(me);
        }
        employess.addAll(employeesData);

        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employees: employess);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
