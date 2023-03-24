import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../features/home/presentation/home.dart';
import '../../../features/home/presentation/home_binding.dart';
import 'routes.dart';

class PageRouter {
  static Route? generateRoutes(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case PageRoutes.HOME:
        return GetPageRoute(
            routeName: PageRoutes.HOME,
            page: () => const Home(),
            binding: HomeBinding());
    }
    return null;
  }
}
