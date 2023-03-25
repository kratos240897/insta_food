import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../../core/base/base_controller.dart';
import '../../../core/base/service_locator.dart';
import '../../../core/constants/enum/snackbar_status.dart';
import '../../../core/init/utils/utils.dart';
import '../data/models/meal.dart';
import '../data/models/meals_order.dart';
import '../domain/use_cases/add_order.dart';
import '../domain/use_cases/get_meals_from_local.dart';
import '../domain/use_cases/get_meals_from_server.dart';
import '../domain/use_cases/put_meals_to_local.dart';

class HomeController extends BaseController {
  final RxList<Meal> meals = RxList.empty();
  final RxList<Meal> selectedMeals = RxList.empty();
  @override
  void onReady() {
    super.onReady();
    getMeals();
  }

  Future<void> getMeals() async {
    Utils().showLoading();
    if (await getIsInternetAvailable()) {
      serviceLocator<GetMealsFromServer>().getMealsFromServer().then((value) {
        Utils().hideLoading();
        value.fold(
            (f) => Utils().showSnackBar(
                'Failure', f.message, SnackBarStatus.failure), (data) {
          meals.value = data;
          serviceLocator<PutMealsToLocal>().putMoviesToLocal(data);
        });
      });
    } else {
      serviceLocator<GetMealsFromLocal>().getMealsFromLocal().then((value) {
        Utils().hideLoading();
        value.fold(
            (f) => Utils()
                .showSnackBar('Failure', f.message, SnackBarStatus.failure),
            (data) => meals.value = data);
      });
    }
  }

  Future<void> placeOrder() async {
    Utils().showLoading();
    final isInternetAvailable = await getIsInternetAvailable();
    final order = MealsOrder(
        meals: selectedMeals,
        createdAt: DateFormat('EEE MMM d yyyy').format(DateTime.now()),
        isExecuted: isInternetAvailable ? true : false);
    serviceLocator<AddOrder>().addOrder(order).then((value) {
      Utils().hideLoading();
      value.fold(
          (f) => Utils().showSnackBar(
              'Failure', f.message, SnackBarStatus.failure), (_) async {
        if (isInternetAvailable) {
          Utils().showSnackBar(
              'Success', 'Order placed successfully', SnackBarStatus.success);
        } else {
          Utils().showSnackBar(
              'No internet',
              'Your order will be executed once you\'re online',
              SnackBarStatus.info);
        }
      });
    });
  }

  @override
  void onNetworkConnected() {
    super.onNetworkConnected();
    if (meals.isEmpty) {
      getMeals();
    }
  }
}
