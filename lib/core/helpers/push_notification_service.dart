import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message received: ${message.messageId}');
  print('Título: ${message.notification?.title}');
  print('Cuerpo: ${message.notification?.body}');
  print('Data: ${message.data}');
}

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GoRouter _router;

  PushNotificationService(this._router);

  Future<void> initialize() async {
    try {
      await requestPermissions();
      await getToken();

      await _handleInitialMessage();
      _listenForegroundMessages();
      _listenMessageOpenedApp();

      if (Platform.isIOS) _listenTokenRefresh();
    } catch (e) {
      print('❌ Error al inicializar notificaciones push: $e');
    }
  }

  Future<void> requestPermissions() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('📱 Permisos de notificación: ${settings.authorizationStatus}');

      if (Platform.isIOS &&
          settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _waitForAPNSToken();
      }
    } catch (e) {
      print('❌ Error al solicitar permisos: $e');
    }
  }

  Future<void> _waitForAPNSToken() async {
    try {
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        print('✅ APNS Token obtenido: ${apnsToken.substring(0, 20)}...');
      } else {
        print('⚠️  APNS Token no disponible - posible simulador');
      }
    } catch (e) {
      print('⚠️  Error al obtener APNS Token: $e');
    }
  }

  void _listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('🔄 FCM Token actualizado: $newToken');
      // TODO: Enviar el nuevo token al backend
    });
  }

  Future<String> getToken() async {
    try {
      if (Platform.isIOS) {
        // En iOS, esperamos un poco para asegurar que APNS esté listo
        await Future.delayed(const Duration(milliseconds: 500));
      }

      String? token = await _firebaseMessaging.getToken();
      
      if (token != null && token.isNotEmpty) {
        print('✅ FCM Token obtenido: ${token.substring(0, 50)}...');
        return token;
      } else {
        print('⚠️  No se pudo obtener FCM Token');
        if (Platform.isIOS) {
          print('⚠️  Posible simulador iOS - las notificaciones no funcionan en simuladores');
        }
        return "";
      }
    } catch (e) {
      print('❌ Error al obtener token FCM: $e');
      return "";
    }
  }

  Future<void> _handleInitialMessage() async {
    try {
      RemoteMessage? initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();

      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }
    } catch (e) {
      print('Error al manejar mensaje inicial: $e');
    }
  }

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificación recibida en foreground: ${message.messageId}');
      print('Título: ${message.notification?.title}');
      print('Cuerpo: ${message.notification?.body}');
      print('Data: ${message.data}');
    });
  }

  void _listenMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print('Manejando mensaje: ${message.messageId}');
    print('Data: ${message.data}');

    // Navegar según el tipo de notificación
    final String? type = message.data['type'];

    switch (type) {
      case 'chat':
        // Ejemplo: navegar a un chat específico
        final String? chatId = message.data['chatId'];
        if (chatId != null) {
          // _router.push('/chat/$chatId');
          print('Navegando a chat: $chatId');
        }
        break;

      case 'match':
        // Ejemplo: navegar a un partido específico
        final String? matchId = message.data['matchId'];
        if (matchId != null) {
          // _router.push('/match/$matchId');
          print('Navegando a partido: $matchId');
        }
        break;

      case 'profile':
        // Ejemplo: navegar a un perfil
        final String? userId = message.data['userId'];
        if (userId != null) {
          // _router.push('/profile/$userId');
          print('Navegando a perfil: $userId');
        }
        break;

      default:
        _router.go('/');
    }
  }

  void dispose() {}
}
