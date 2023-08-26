import 'dart:developer';

import 'package:barber_app_reservation/src/core/fp/nil.dart';
import 'package:dio/dio.dart';

import 'package:barber_app_reservation/src/core/Exceptions/repository_exception.dart';
import 'package:barber_app_reservation/src/core/fp/either.dart';
import 'package:barber_app_reservation/src/core/restClient/rest_client.dart';
import 'package:barber_app_reservation/src/model/barbershop_model.dart';
import 'package:barber_app_reservation/src/model/user_model.dart';

import 'barbershop_repository.dart';

class BarbershopRepositoryImp implements BarbershopRepository {
  final RestClient restClient;
  BarbershopRepositoryImp({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef' // only for use with json-rest-server
          },
        );
        return Success(BarbershopModel.fromMap(data));

      case UserModeEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );

        return Success(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
      await restClient.auth.post('/barbershop', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours
      });
      return Success(nil);
    } on Exception catch (error, stackTrace) {
      log('Erro ao registrar barbearia', error: error, stackTrace: stackTrace);
      return Failure(
          RepositoryException(message: 'Erro ao registrar barbearia'));
    }
  }
}
