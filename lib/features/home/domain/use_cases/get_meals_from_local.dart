import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/meal.dart';
import '../repository/home_repository.dart';

class GetMealsFromLocal {
  Future<Either<Failure, List<Meal>>> getMealsFromLocal() {
    return serviceLocator<HomeRepository>().getMealsFromLocal();
  }
}
