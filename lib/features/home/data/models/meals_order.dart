import 'package:hive/hive.dart';

import 'meal.dart';
part 'meals_order.g.dart';

@HiveType(typeId: 1)
class MealsOrder extends HiveObject {
  @HiveField(0)
  late final List<Meal> meals;
  @HiveField(1)
  late final String createdAt;
  @HiveField(2)
  late bool isExecuted;
  MealsOrder(
      {required this.meals, required this.createdAt, this.isExecuted = false});
}
