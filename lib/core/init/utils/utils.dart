import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import '../../constants/app/styles.dart';
import '../../constants/enum/snackbar_status.dart';

class Utils {
  Utils._();
  static Utils? _instance;
  factory Utils() {
    return _instance ?? Utils._();
  }
  final context = Get.context!;
  showSnackBar(String title, String message, SnackBarStatus status) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15.w),
        content: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 0.06.sh, maxHeight: 0.1.sh),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  color: status == SnackBarStatus.success
                      ? Colors.green
                      : status == SnackBarStatus.failure
                          ? Colors.red
                          : Colors.blue,
                  borderRadius: BorderRadius.circular(5.r)),
              width: 0.02.sw,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Styles.textStyles.f14Bold),
                  6.verticalSpace,
                  Text(message, style: Styles.textStyles.f14SemiBold),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Icon(
                Icons.close,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            )
          ]),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return SizedBox(
                    height: Get.height * 0.25,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Loading... 🍿',
                            style: Styles.textStyles.f18Bold,
                          ),
                          12.verticalSpace,
                          const CupertinoActivityIndicator(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
  }

  hideLoading() {
    Navigator.pop(context);
  }
}
