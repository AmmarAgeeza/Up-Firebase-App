import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/commons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTo();
  }

  void navigateTo() async {
    bool isVisted = await sl<CacheHelper>().getData(
          key: AppStrings.onBoardingKey,
        ) ??
        false;
    Future.delayed(const Duration(seconds: 3), () {
      navigate(
          context: context, route: isVisted ? Routes.login : Routes.onBoarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(AppAssets.logo),
          SizedBox(height: 24.h),
          Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 40,
                  color: AppColors.white,
                ),
          )
        ],
      )),
    );
  }
}
