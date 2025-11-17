import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

/// Handler para notificaciones recibidas cuando la app está en background/terminated
/// Debe ser una función top-level para que Firebase pueda ejecutarla
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message received: ${message.messageId}');
  print('Título: ${message.notification?.title}');
  print('Cuerpo: ${message.notification?.body}');
  print('Data: ${message.data}');
}

/// Servicio centralizado para manejar notificaciones push
/// Se inicializa una sola vez en main.dart para evitar listeners duplicados
class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GoRouter _router;

  PushNotificationService(this._router);

  /// Detecta si está corriendo en un simulador iOS
  bool get _isIOSSimulator {
    if (!Platform.isIOS) return false;
    // En simuladores, defaultTargetPlatform es iOS pero no hay capacidades APNS
    return !kReleaseMode && Platform.isIOS;
  }

  /// Inicializa el servicio de notificaciones
  /// - Solicita permisos
  /// - Configura listeners para notificaciones en foreground y cuando se abre la app
  /// - Maneja el mensaje inicial si la app se abrió desde una notificación
  Future<void> initialize() async {
    try {
      if (_isIOSSimulator) {
        print('⚠️  ADVERTENCIA: Estás en un simulador iOS');
        print('⚠️  Las notificaciones push NO funcionan en simuladores');
        print('⚠️  El token APNS solo está disponible en dispositivos físicos');
        print('⚠️  Para probar notificaciones, usa un iPhone/iPad real');
      }

      // Solicitar permisos de notificaciones
      await _requestPermissions();

      // Obtener el token FCM (útil para enviar notificaciones específicas a este dispositivo)
      await _getToken();

      // Manejar el mensaje inicial si la app se abrió desde una notificación cerrada
      await _handleInitialMessage();

      // Escuchar notificaciones cuando la app está en foreground
      _listenForegroundMessages();

      // Escuchar cuando el usuario toca una notificación y la app estaba en background
      _listenMessageOpenedApp();

      // En iOS físico, escuchar cuando el token APNS esté disponible
      if (Platform.isIOS && !_isIOSSimulator) {
        _listenTokenRefresh();
      }
    } catch (e) {
      print('❌ Error al inicializar notificaciones push: $e');
    }
  }

  /// Solicita permisos de notificaciones al usuario
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

      // En iOS físico, esperar a que APNS esté disponible
      if (Platform.isIOS &&
          !_isIOSSimulator &&
          settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _waitForAPNSToken();
      }
    } catch (e) {
      print('❌ Error al solicitar permisos: $e');
    }
  }

  /// Espera a que el token APNS esté disponible en iOS
  Future<void> _waitForAPNSToken() async {
    if (_isIOSSimulator) return;

    try {
      // Intentar obtener el token APNS
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        print('🍎 APNS Token obtenido: $apnsToken');
      } else {
        print('⏳ APNS Token aún no disponible, se obtendrá automáticamente');
      }
    } catch (e) {
      // Si falla, no es crítico, el token se obtendrá cuando esté disponible
      print('⚠️  APNS Token no disponible aún: $e');
    }
  }

  /// Escucha cuando el token se actualiza (especialmente útil en iOS)
  void _listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('🔄 FCM Token actualizado: $newToken');
      // TODO: Enviar el nuevo token al backend
    });
  }

  /// Obtiene el token FCM del dispositivo
  Future<void> _getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print('🔑 FCM Token: $token');
        if (_isIOSSimulator) {
          print(
            '⚠️  NOTA: Este token NO funcionará para notificaciones en simulador',
          );
        }
        // TODO: Enviar este token al backend para poder enviar notificaciones específicas
      } else {
        print('⚠️  No se pudo obtener el FCM Token');
      }
    } catch (e) {
      print('❌ Error al obtener token FCM: $e');
    }
  }

  /// Maneja el mensaje inicial si la app se abrió desde una notificación cerrada
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

  /// Escucha notificaciones cuando la app está en foreground
  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificación recibida en foreground: ${message.messageId}');
      print('Título: ${message.notification?.title}');
      print('Cuerpo: ${message.notification?.body}');
      print('Data: ${message.data}');

      // Aquí puedes mostrar un dialog o snackbar si deseas
      // O manejar la notificación de forma silenciosa
    });
  }

  /// Escucha cuando el usuario toca una notificación y la app estaba en background
  void _listenMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// Maneja la navegación según el tipo de notificación
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
        // Si no hay tipo específico, ir al home
        _router.go('/');
    }
  }

  /// Libera recursos del servicio (opcional, para casos especiales)
  void dispose() {
    // Aquí podrías cancelar suscripciones si fuera necesario
  }
}
