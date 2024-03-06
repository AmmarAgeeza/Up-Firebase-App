import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/app_strings.dart';

class UpChatApp extends StatelessWidget {
  const UpChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return MaterialApp(
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          title: AppStrings.appName,
          theme: getAppTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.intitlRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
