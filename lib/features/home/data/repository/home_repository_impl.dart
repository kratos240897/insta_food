

import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/meals_local_data_source.dart';
import '../data_source/meals_remote_data_source.dart';
import '../data_source/orders_local_data_source.dart';
import '../models/meal.dart';
import '../models/meals_order.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, List<Meal>>> getMealsFromLocal() {
    return serviceLocator<MealsLocalDataSource>().getMealsFromLocal();
  }

  @override
  Future<Either<Failure, List<Meal>>> getMealsFromServer() {
    return serviceLocator<MealsRemoteDataSource>().getMealsFromServer();
  }

  @override
  Future<Either<Failure, void>> putMealsToLocal(List<Meal> meals) {
    return serviceLocator<MealsLocalDataSource>().putMealsToLocal(meals);
  }

  @override
  Future<Either<Failure, void>> putOrdersToLocal(MealsOrder order) {
    return serviceLocator<OrdersLocalDataSource>().addOrder(order);
  }
  
  @override
  Future<Either<Failure, bool>> executeOrders() {
    return serviceLocator<OrdersLocalDataSource>().executeOrders();
  }
}
