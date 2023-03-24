import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/init/local_storage/boxes.dart';
import '../models/meals_order.dart';

abstract class OrdersLocalDataSource {
  Future<Either<Failure, void>> addOrder(MealsOrder order);
  Future<Either<Failure, void>> executeOrders();
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
  Future<Either<Failure, void>> executeOrders() async {
    try {
      Boxes.getOrders().values.toList().forEach((element) {
        element.isExecuted = true;
        element.save();
      });
      return const Right(null);
    } on HiveError {
      return const Left(
          LocalDatabaseQueryFailure(message: 'Unable to add data to Database'));
    } on Exception {
      return const Left(UnknownFailure(message: 'Something went wrong'));
    }
  }
}
