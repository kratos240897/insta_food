import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../repository/home_repository.dart';

class ExecuteOrder {
  Future<Either<Failure, bool>> executeOrders() {
    return serviceLocator<HomeRepository>().executeOrders();
  }
}