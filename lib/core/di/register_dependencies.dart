import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:futbolitonew/core/environment/env.dart';
import 'package:futbolitonew/common/domain/entities/environment_entity.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:futbolitonew/core/helpers/push_notification_service.dart';
import 'package:futbolitonew/core/navigator/router.dart';
import 'package:futbolitonew/features/auth/di/register_dependencies.dart'
    as auth_di;
import 'package:futbolitonew/features/home/di/register_dependencies.dart'
    as invitations_friends_di;
import 'package:futbolitonew/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// Language
  getIt.registerSingleton<Internationalization>(SpanishInternationalization());

  /// Environment
  getIt.registerSingleton<IEnvironment>(EnvironmentProd());

  /// External Services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: getIt<IEnvironment>().supabase['url']!,
    anonKey: getIt<IEnvironment>().supabase['anonKey']!,
  );

  await Firebase.initializeApp();

  getIt.registerSingleton(appRouter);

  getIt.registerSingleton<PushNotificationService>(
    PushNotificationService(appRouter),
  );

  await getIt<PushNotificationService>().initialize();

  /// Features
  auth_di.authRegisterDependencies();
  invitations_friends_di.invitationsRegisterDependencies();

  //  getIt.registerSingleton<ApiClient>(ApiClient());
}
