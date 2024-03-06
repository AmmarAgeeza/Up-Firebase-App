import 'package:flutter/material.dart';

import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
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
    bool isLogin = await sl<CacheHelper>().getData(key: 'id') != null;
    Future.delayed(const Duration(seconds: 3), () {
      navigateRepacement(
          context: context, route: isLogin ? Routes.home : Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.auth),
          // SizedBox(height: 24.h),
          // Text(
          //   AppStrings.appName,
          //   style: Theme.of(context).textTheme.displayLarge!.copyWith(
          //         fontSize: 40,
          //         color: AppColors.primary,
          //       ),
          // )
        ],
      )),
    );
  }
}
