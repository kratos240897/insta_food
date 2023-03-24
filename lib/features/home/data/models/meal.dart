import 'package:hive/hive.dart';
part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal extends HiveObject {
  Meal(
      {required this.strMeal,
      required this.strMealThumb,
      required this.idMeal,
      required this.isSelected});
  @HiveField(0)
  late final String strMeal;
  @HiveField(1)
  late final String strMealThumb;
  @HiveField(2)
  late final String idMeal;
  @HiveField(3)
  late bool isSelected;

  Meal.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    data['isSelected'] = isSelected;
    return data;
  }
}
