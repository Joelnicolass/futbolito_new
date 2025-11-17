import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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

  bool get _isIOSSimulator {
    if (!Platform.isIOS) return false;
    return !kReleaseMode && Platform.isIOS;
  }

  Future<void> initialize() async {
    try {
      if (_isIOSSimulator) {
        print('⚠️  ADVERTENCIA: Estás en un simulador iOS');
        print('⚠️  Las notificaciones push NO funcionan en simuladores');
        print('⚠️  El token APNS solo está disponible en dispositivos físicos');
        print('⚠️  Para probar notificaciones, usa un iPhone/iPad real');
      }
      await _requestPermissions();
      await _getToken();
      await _handleInitialMessage();
      _listenForegroundMessages();
      _listenMessageOpenedApp();

      if (Platform.isIOS && !_isIOSSimulator) _listenTokenRefresh();
    } catch (e) {
      print('❌ Error al inicializar notificaciones push: $e');
    }
  }

  Future<void> _requestPermissions() async {
    try {
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(
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
          !_isIOSSimulator &&
          settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _waitForAPNSToken();
      }
    } catch (e) {
      print('❌ Error al solicitar permisos: $e');
    }
  }

  Future<void> _waitForAPNSToken() async {
    if (_isIOSSimulator) return;
    try {
      await _firebaseMessaging.getAPNSToken();
    } catch (e) {
      print('⚠️  APNS Token no disponible aún: $e');
    }
  }

  void _listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('🔄 FCM Token actualizado: $newToken');
      // TODO: Enviar el nuevo token al backend
    });
  }

  Future<void> _getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print('🔑 FCM Token: $token');

        // TODO: Enviar este token al backend para poder enviar notificaciones específicas
      } else {
        print('⚠️  No se pudo obtener el FCM Token');
      }
    } catch (e) {
      print('❌ Error al obtener token FCM: $e');
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
