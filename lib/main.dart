import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'utils/theme/theme.dart';

main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
          builder: InAppNotifications.init(), // BotToastInit(),
          home: Container(
            color: Colors.amber,
            child: const Center(child: Text("Hello World")),
          ),
        );
      },
    );
  }
}
