import 'meal.dart';

class MealsResponse {
  MealsResponse({
    required this.meals,
  });
  late final List<Meal> meals;

  MealsResponse.fromJson(Map<String, dynamic> json) {
    meals = List.from(json['meals']).map((e) => Meal.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meals'] = meals.map((e) => e.toJson()).toList();
    return data;
  }
}
