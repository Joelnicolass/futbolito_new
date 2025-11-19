import 'package:futbolitonew/core/helpers/push_notification_service.dart';
import 'package:futbolitonew/features/auth/domain/usecases/register_fcm_token_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';
import 'package:futbolitonew/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:futbolitonew/features/auth/domain/usecases/sign_out_usecase.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    final useCase = getIt<GetCurrentUserUseCase>();
    return await useCase();
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCaseSignIn = getIt<SignInWithGoogleUseCase>();
      final useCaseRegisterUser = getIt<RegisterUserUseCase>();
      final useCaseRegisterFcmToken = getIt<RegisterFcmTokenUseCase>();

      // Login con Firebase
      final firebaseUser = await useCaseSignIn();
      
      // Registrar usuario en Supabase (retorna el usuario con el ID de Supabase)
      final supabaseUser = await useCaseRegisterUser(
        firebaseUid: firebaseUser.id,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoUrl,
      );

      print('🔐 Usuario registrado - ID Supabase: ${supabaseUser.id}');
      print('👤 Display Name: ${supabaseUser.displayName}');
      print('📸 Photo URL: ${supabaseUser.photoUrl}');

      // Registrar token FCM usando el ID de Supabase
      try {
        final fcmToken = await getIt<PushNotificationService>().getToken();
        if (fcmToken.isNotEmpty) {
          await useCaseRegisterFcmToken(userId: supabaseUser.id, token: fcmToken);
          print('✅ FCM Token registrado en Supabase');
        } else {
          print('⚠️  FCM Token vacío, omitiendo registro');
        }
      } catch (e) {
        print('⚠️  Error al registrar FCM token: $e');
      }

      return supabaseUser;
    });
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCaseSignIn = getIt<SignInWithAppleUseCase>();
      final useCaseRegisterUser = getIt<RegisterUserUseCase>();
      final useCaseRegisterFcmToken = getIt<RegisterFcmTokenUseCase>();

      // Login con Firebase
      final firebaseUser = await useCaseSignIn();
      
      // Registrar usuario en Supabase (retorna el usuario con el ID de Supabase)
      final supabaseUser = await useCaseRegisterUser(
        firebaseUid: firebaseUser.id,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoUrl,
      );

      print('🔐 Usuario registrado - ID Supabase: ${supabaseUser.id}');
      print('👤 Display Name: ${supabaseUser.displayName}');
      print('📸 Photo URL: ${supabaseUser.photoUrl}');

      // Registrar token FCM usando el ID de Supabase
      try {
        final fcmToken = await getIt<PushNotificationService>().getToken();
        if (fcmToken.isNotEmpty) {
          await useCaseRegisterFcmToken(userId: supabaseUser.id, token: fcmToken);
          print('✅ FCM Token registrado en Supabase');
        } else {
          print('⚠️  FCM Token vacío, omitiendo registro');
        }
      } catch (e) {
        print('⚠️  Error al registrar FCM token: $e');
      }

      return supabaseUser;
    });
  }

  Future<void> signOut() async {
    final useCase = getIt<SignOutUseCase>();
    await useCase();
  }
}
