import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/meals_order.dart';
import '../repository/home_repository.dart';

class AddOrder {
  Future<Either<Failure, void>> addOrder(MealsOrder order) {
    return serviceLocator<HomeRepository>().putOrdersToLocal(order);
  }
}