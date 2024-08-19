// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber_app_reservation/src/model/user_model.dart';

enum HomeAdmStateStatus { loaded, error }

class HomeAdmState {
  final HomeAdmStateStatus status;
  final List<UserModel> employees;

  HomeAdmState({required this.status, required this.employees});

  HomeAdmState copyWith({
    HomeAdmStateStatus? status,
    List<UserModel>? employees,
  }) {
    return HomeAdmState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }
}
