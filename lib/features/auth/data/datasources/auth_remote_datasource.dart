import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// DataSource remoto para autenticación
/// Maneja la comunicación directa con Firebase Auth y Google Sign In
class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSource({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn =
          googleSignIn ??
          GoogleSignIn(
            // Web Client ID necesario para Android
            // Obtenerlo de: Firebase Console > Project Settings > General > Web Client ID
            //clientId:
            //    '487331532356-fba19vqkkj3t288i87jkblononmr8cjj.apps.googleusercontent.com',
            scopes: ['email'],
          );

  /// Inicia sesión con Google
  /// Retorna el UserCredential de Firebase
  Future<UserCredential> signInWithGoogle() async {
    // Inicia el flujo de autenticación de Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('El usuario canceló el inicio de sesión');
    }

    // Obtiene los detalles de autenticación de la solicitud
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Crea un nuevo credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Inicia sesión en Firebase con el credential de Google
    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Inicia sesión con Apple
  /// Retorna el UserCredential de Firebase
  Future<UserCredential> signInWithApple() async {
    // Solicita las credenciales de Apple
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Crea el credential de OAuth para Firebase
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Inicia sesión en Firebase con el credential de Apple
    return await _firebaseAuth.signInWithCredential(oauthCredential);
  }

  /// Obtiene el usuario actual de Firebase
  User? getCurrentFirebaseUser() {
    return _firebaseAuth.currentUser;
  }

  /// Cierra sesión
  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  /// Stream de cambios de autenticación
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
