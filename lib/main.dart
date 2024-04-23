import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:tak/app_observer.dart';
import 'package:tak/config/routes/router.dart';
import 'package:tak/config/theme/theme.dart';
import 'package:tak/core/services/get_it_services.dart';
import 'package:tak/core/services/notification_service.dart';
import 'package:tak/core/services/stream_listener.dart';
import 'package:tak/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tak/features/service_request/presentation/bloc/service_request_bloc.dart';
import 'package:tak/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:tak/features/visitors/presentation/bloc/visitors_bloc.dart';
import 'package:tak/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    NotificationService.display(message);
  }
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupLocator();

  Bloc.observer = AppObserver(logger: getIt<Logger>());
  NotificationService.initialize();
  FirebaseMessaging messaging = getIt<FirebaseMessaging>();

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  // String? token = await messaging.getToken();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      NotificationService.display(message);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const TakEstate());

  FlutterNativeSplash.remove();
}

class TakEstate extends StatelessWidget {
  const TakEstate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(CheckLoginEvent()),
        ),
        BlocProvider<VisitorsBloc>(create: (_) => getIt<VisitorsBloc>()),
        BlocProvider<ServiceRequestBloc>(
            create: (_) => getIt<ServiceRequestBloc>()),
        BlocProvider<TransactionBloc>(create: (_) => getIt<TransactionBloc>()),
      ],
      child: AuthStreamScope(
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              title: 'Tak Estate',
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              builder: InAppNotifications.init(), // BotToastInit(),
            );
          },
        ),
      ),
    );
  }
}
