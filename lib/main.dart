
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tak/firebase_options.dart';

import 'config/theme/theme.dart';
import 'features/onboard/presentation/pages/onboarding.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const TakEstate());

  FlutterNativeSplash.remove();
}

class TakEstate extends StatelessWidget {
  const TakEstate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          title: 'Tak Estate',
          debugShowCheckedModeBanner: false,
          builder: InAppNotifications.init(),
          // BotToastInit(),
          home: const Onboarding(),
        );
      },
    );
  }
}
