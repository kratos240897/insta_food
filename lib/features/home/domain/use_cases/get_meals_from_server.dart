import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/meal.dart';
import '../repository/home_repository.dart';

class GetMealsFromServer {
  Future<Either<Failure, List<Meal>>> getMealsFromServer() {
    return serviceLocator<HomeRepository>().getMealsFromServer();
  }
}
