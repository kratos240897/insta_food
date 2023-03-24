import 'package:get_it/get_it.dart';


import '../../features/home/data/data_source/meals_local_data_source.dart';
import '../../features/home/data/data_source/meals_remote_data_source.dart';
import '../../features/home/data/data_source/orders_local_data_source.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/repository/home_repository.dart';
import '../../features/home/domain/use_cases/add_order.dart';
import '../../features/home/domain/use_cases/execute_order.dart';
import '../../features/home/domain/use_cases/get_meals_from_local.dart';
import '../../features/home/domain/use_cases/get_meals_from_server.dart';
import '../../features/home/domain/use_cases/put_meals_to_local.dart';
import '../service/api_service.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServiceLocator() async {
  // services
  serviceLocator.registerSingleton<ApiService>(ApiService());

  // data sources
  serviceLocator.registerFactory<MealsRemoteDataSource>(
      () => MealsRemoteDataSourceImpl());
  serviceLocator
      .registerFactory<MealsLocalDataSource>(() => MealsLocalDataSourceImpl());
      serviceLocator
      .registerFactory<OrdersLocalDataSource>(() => OrdersLocalDataSourceImpl());

  // repositories
  serviceLocator.registerFactory<HomeRepository>(() => HomeRepositoryImpl());

  // use cases
  serviceLocator.registerFactory(() => GetMealsFromServer());
  serviceLocator.registerFactory(() => GetMealsFromLocal());
  serviceLocator.registerFactory(() => PutMealsToLocal());
  serviceLocator.registerFactory(() => AddOrder());
  serviceLocator.registerFactory(() => ExecuteOrder());
}
