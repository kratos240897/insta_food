import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app/styles.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.find<HomeController>();
  var isSelectionEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insta Food'),
      ),
      body: Obx(() {
        return controller.meals.isEmpty
            ? Center(
                child: Text(
                  'First time you need an Internet Connection to store Meals locally',
                  textAlign: TextAlign.center,
                  style: Styles.textStyles.f16Regular,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 16.h),
                itemCount: controller.meals.length,
                itemBuilder: (context, index) {
                  final meal = controller.meals[index];

                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        isSelectionEnabled = true;
                      });
                      meal.isSelected = true;
                      controller.selectedMeals.add(meal);
                    },
                    onTap: () {
                      if (isSelectionEnabled) {
                        setState(() {
                          meal.isSelected = !meal.isSelected;
                          if (meal.isSelected) {
                            controller.selectedMeals.add(meal);
                          } else {
                            controller.selectedMeals.remove(meal);
                          }
                        });
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  topRight: Radius.circular(12.r)),
                              child: CachedNetworkImage(
                                imageUrl: meal.strMealThumb,
                                height: 0.3.sh,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                          8.verticalSpace,
                          Row(
                            children: [
                              6.horizontalSpace,
                              Expanded(
                                child: Text(
                                  meal.strMeal,
                                  style: Styles.textStyles.f14SemiBold,
                                ),
                              ),
                              if (isSelectionEnabled)
                                Icon(
                                  meal.isSelected
                                      ? Icons.check_circle_rounded
                                      : Icons.circle_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 28.spMin,
                                ),
                            ],
                          ),
                          8.verticalSpace
                        ],
                      ),
                    ),
                  );
                });
      }),
      bottomNavigationBar: isSelectionEnabled
          ? Container(
              height: 0.12.sh,
              padding: EdgeInsets.only(bottom: 4.h),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r)),
                  color: Theme.of(context).primaryColor),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          controller.placeOrder().then((value) {
                            isSelectionEnabled = false;
                            controller.selectedMeals.clear();
                            setState(() {});
                          });
                        },
                        child: Text(
                          'Done',
                          style: Styles.textStyles.f14Bold
                              ?.copyWith(color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                          controller.selectedMeals.length.toString(),
                          style: Styles.textStyles.f16Bold
                              ?.copyWith(color: Colors.white),
                        );
                      }),
                      6.horizontalSpace,
                      Text(
                        'meals selected',
                        style: Styles.textStyles.f16Regular
                            ?.copyWith(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            )
          : null,
    );
  }
}
