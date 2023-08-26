import 'package:barber_app_reservation/src/core/Exceptions/repository_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/fp/nil.dart';
import 'package:barber_app_reservation/src/model/barbershop_model.dart';
import 'package:barber_app_reservation/src/model/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, Nil>> save(
      ({
        String name,
        String email,
        List<String> openingDays,
        List<int> openingHours,
      }) data);

  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
}
