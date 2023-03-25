import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../data/models/meal.dart';
import '../../data/models/meals_order.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Meal>>> getMealsFromServer();
  Future<Either<Failure, List<Meal>>> getMealsFromLocal();
  Future<Either<Failure, void>> putMealsToLocal(List<Meal> meals);
  Future<Either<Failure, void>> putOrdersToLocal(MealsOrder order);
  Future<Either<Failure, bool>> executeOrders();
}
