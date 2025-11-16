import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
