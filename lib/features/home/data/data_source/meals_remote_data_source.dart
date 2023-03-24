import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../../../core/constants/app/end_points.dart';
import '../../../../core/service/api_service.dart';
import '../models/meal.dart';
import '../models/meals_reponse.dart';

abstract class MealsRemoteDataSource {
  Future<Either<Failure, List<Meal>>> getMealsFromServer();
}

class MealsRemoteDataSourceImpl extends MealsRemoteDataSource {
  @override
  Future<Either<Failure, List<Meal>>> getMealsFromServer() async {
    try {
      final apiService = serviceLocator<ApiService>();
      final res =
          await apiService.getRequest(Endpoints.filter, {'c': 'Seafood'});
      if (res.statusCode == 200) {
        return Right(MealsResponse.fromJson(res.data).meals);
      }
      return const Left(UnknownFailure(message: 'Something went wrong'));
    } on SocketException {
      return const Left(
          ConnectionFailure(message: 'Please check your Internet Connection'));
    } on FormatException {
      return const Left(
          ConnectionFailure(message: 'Invalid response from server'));
    } on Exception {
      return const Left(UnknownFailure(message: 'Something went wrong'));
    }
  }
}
