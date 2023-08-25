// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
