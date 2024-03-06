import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firebase/feature/home/presentation/cubit/home_cubit.dart';

import '../core/routes/app_routes.dart';
import '../core/services/service_locator.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/app_strings.dart';

class UpChatApp extends StatelessWidget {
  const UpChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return BlocProvider(
          create: (context) => HomeCubit(sl()),
          child: MaterialApp(
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
            ],
            // localizationsDelegates: const [
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
            title: AppStrings.appName,
            theme: getAppTheme(),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.intitlRoute,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
