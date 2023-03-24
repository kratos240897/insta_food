import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/meal.dart';
import '../repository/home_repository.dart';

class PutMealsToLocal {
  Future<Either<Failure, void>> putMoviesToLocal(List<Meal> meals) {
    return serviceLocator<HomeRepository>().putMealsToLocal(meals);
  }
}
