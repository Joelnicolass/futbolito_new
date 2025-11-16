import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:futbolitonew/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modelo de datos de usuario
/// Usa Freezed para inmutabilidad y serialización JSON
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
  }) = _UserModel;

  /// Crea un UserModel desde un User de Firebase Auth
  factory UserModel.fromFirebaseUser(
    String id,
    String email, {
    String? displayName,
    String? photoUrl,
  }) {
    return UserModel(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  /// Deserializa desde JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Extensión para convertir UserModel a User (entidad)
extension UserModelX on UserModel {
  /// Convierte el modelo a entidad del dominio
  User toEntity() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
