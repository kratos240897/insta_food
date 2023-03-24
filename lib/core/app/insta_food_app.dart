import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app/constants.dart';
import '../constants/app/styles.dart';
import '../init/routing/router.dart';
import '../init/routing/routes.dart';

class InstaFoodApp extends StatelessWidget {
  const InstaFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(primarySwatch: Styles.colors.kPrimaryColor,
          fontFamily: GoogleFonts.poppins().fontFamily
          ),
          debugShowCheckedModeBanner: false,
          title: Constants.APP_NAME,
          onGenerateRoute: PageRouter.generateRoutes,
          initialRoute: PageRoutes.HOME,
        );
      }
    );
  }
}
