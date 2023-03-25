import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/init/local_storage/boxes.dart';
import '../models/meals_order.dart';

abstract class OrdersLocalDataSource {
  Future<Either<Failure, void>> addOrder(MealsOrder order);
  Future<Either<Failure, bool>> executeOrders();
}

class OrdersLocalDataSourceImpl extends OrdersLocalDataSource {
  @override
  Future<Either<Failure, void>> addOrder(MealsOrder order) async {
    try {
      Boxes.getOrders().add(order);
      return const Right(null);
    } on HiveError {
      return const Left(
          LocalDatabaseQueryFailure(message: 'Unable to add data to Database'));
    } on Exception {
      return const Left(UnknownFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> executeOrders() async {
    bool isOrdersExecuted = false;
    try {
      Boxes.getOrders().values.toList().forEach((element) {
        if (element.isExecuted == false) {
          element.isExecuted = true;
          element.save();
          isOrdersExecuted = true;
        }
      });
      return Right(isOrdersExecuted);
    } on HiveError {
      return const Left(
          LocalDatabaseQueryFailure(message: 'Unable to execute orders'));
    } on Exception {
      return const Left(UnknownFailure(message: 'Something went wrong'));
    }
  }
}
