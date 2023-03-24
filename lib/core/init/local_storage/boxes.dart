import 'package:hive/hive.dart';

import '../../../features/home/data/models/meal.dart';
import '../../../features/home/data/models/meals_order.dart';
import '../../constants/app/constants.dart';

class Boxes {
  static Box<Meal> getMeals() => Hive.box(Constants.MEALS_DB);
  static Box<MealsOrder> getOrders() => Hive.box(Constants.ORDERS_DB);
}
