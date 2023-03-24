import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../../../core/base/failure.dart';
import '../../../../core/init/local_storage/boxes.dart';
import '../models/meal.dart';

abstract class MealsLocalDataSource {
  Future<Either<Failure, List<Meal>>> getMealsFromLocal();
  Future<Either<Failure, void>> putMealsToLocal(List<Meal> meals);
}

class MealsLocalDataSourceImpl extends MealsLocalDataSource {
  @override
  Future<Either<Failure, List<Meal>>> getMealsFromLocal() async {
    try {
      final meals = Boxes.getMeals().values.toList();
      return Right(meals);
    } on HiveError {
      return const Left(LocalDatabaseQueryFailure(
          message: 'Unable to load data from Database'));
    } on Exception {
      return const Left(UnknownFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, void>> putMealsToLocal(List<Meal> meals) async {
    try {
      Boxes.getMeals().clear();
      Boxes.getMeals().addAll(meals);
      return const Right(null);
    } on HiveError {
      return const Left(
          LocalDatabaseQueryFailure(message: 'Unable to add data to Database'));
    } on Exception {
      return const Left(UnknownFailure(message: 'Something went wrong'));
    }
  }
}
