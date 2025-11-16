import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Entidad de usuario del dominio
/// Representa un usuario autenticado sin dependencias externas
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
  }) = _User;
}
