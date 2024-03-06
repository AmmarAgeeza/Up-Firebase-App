import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/app.dart';
import '/core/database/cache/cache_helper.dart';
import '/feature/auth/presentation/cubit/auth_cubit.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLoactor();
  await Future.wait([
    sl<CacheHelper>().init(),
    Firebase.initializeApp(),
  ]);
  // await sl<CacheHelper>().sharedPreferences.clear();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
      ],
      child: const UpChatApp(),
    ),
  );
}
