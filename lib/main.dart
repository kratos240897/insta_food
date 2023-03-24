import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';

import 'core/app/boot_strap.dart';
import 'core/app/insta_food_app.dart';
import 'core/base/service_locator.dart';
import 'core/constants/app/constants.dart';
import 'features/home/data/models/meal.dart';
import 'features/home/data/models/meals_order.dart';

void main() async {
  await initHive();
  await setUpServiceLocator();
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );
  bootstrap(() => const InstaFoodApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(MealsOrderAdapter());
  await Hive.openBox<Meal>(Constants.MEALS_DB);
  await Hive.openBox<MealsOrder>(Constants.ORDERS_DB);
}
