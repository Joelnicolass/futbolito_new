# Arquitectura y Reglas de Desarrollo

## 🏗️ Clean Architecture

Este proyecto sigue los principios de Clean Architecture con la siguiente estructura por feature:

```
features/
└── feature_name/
    ├── domain/
    │   ├── entities/       # Entidades de negocio (con @freezed)
    │   ├── repositories/   # Interfaces de repositorios
    │   └── usecases/      # Casos de uso
    ├── data/
    │   ├── datasources/   # Fuentes de datos (API, local, etc)
    │   ├── repositories/  # Implementaciones de repositorios
    │   ├── models/        # Modelos de datos (con @freezed)
    │   └── di/           # Registro de dependencias del feature
    └── presentation/
        ├── providers/     # Providers de estado (con @riverpod)
        ├── screens/       # Pantallas/páginas
        └── widgets/       # Widgets específicos del feature
```

## 📦 Annotations Requeridas

### Freezed para Entidades, Estados y Modelos

Todas las entidades, estados y modelos deben usar **Freezed annotations**:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mi_entidad.freezed.dart';
part 'mi_entidad.g.dart';

@freezed
class MiEntidad with _$MiEntidad {
  const factory MiEntidad({
    required String id,
    required String nombre,
  }) = _MiEntidad;

  factory MiEntidad.fromJson(Map<String, dynamic> json) =>
      _$MiEntidadFromJson(json);
}
```

### Riverpod Annotations para Gestión de Estado

Todos los providers deben usar **Riverpod annotations** (no StateProvider manual):

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mi_provider.g.dart';

@riverpod
class MiNotifier extends _$MiNotifier {
  @override
  int build() => 0;

  void increment() => state++;
}
```

## 🔧 Inyección de Dependencias con GetIt

### Registro por Feature

Cada feature tiene su propio archivo `register_dependencies.dart`:

```dart
// features/mi_feature/data/di/register_dependencies.dart
import 'package:futbolitonew/core/di/register_dependencies.dart';

Future<void> registerMiFeatureDependencies() async {
  // Datasources
  getIt.registerLazySingleton<MiDatasource>(
    () => MiDatasourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<MiRepository>(
    () => MiRepositoryImpl(getIt()),
  );

  // Usecases
  getIt.registerLazySingleton(() => MiUseCase(getIt()));
}
```

### Registro Global

En el archivo principal `core/di/register_dependencies.dart`:

```dart
Future<void> configureDependencies() async {
  // Registrar dependencias de cada feature
  await registerAuthDependencies();
  await registerHomeDependencies();
  await registerMiFeatureDependencies();
}
```

## 🌐 Internacionalización

### Todos los textos deben ir en traducciones

**❌ NO hacer:**

```dart
Text('Hola Mundo')
'Bienvenido'.toTextFoundation()
```

**✅ SÍ hacer:**

```dart
// 1. Agregar al enum en core/intl/intl.dart
enum Translate {
  welcome,
  hello,
}

// 2. Agregar traducciones en core/intl/translations/
// es.dart
Translate.welcome: 'Bienvenido',
Translate.hello: 'Hola',

// 3. Usar en el código
Translate.welcome.toTextFoundation()
```

## 📋 Convenciones de Código

### Nomenclatura

- **Clases**: PascalCase (`UserEntity`, `AuthRepository`)
- **Archivos**: snake_case (`user_entity.dart`, `auth_repository.dart`)
- **Variables/Funciones**: camelCase (`getUserData`, `isAuthenticated`)
- **Constantes**: camelCase con `const` (`const maxAttempts = 3`)

### Imports

Orden de imports:

1. Dart/Flutter
2. Packages externos
3. Archivos del proyecto

```dart
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:futbolitonew/common/...dart';
import 'package:futbolitonew/features/...dart';
```

## 🎨 UI/UX

### Widgets Foundation

Siempre usar los widgets foundation del proyecto:

- `ScaffoldFoundation` en lugar de `Scaffold`
- `.toTextFoundation()` para textos
- `.toButtonFoundation()` para botones
- `SpacingFoundation` para espaciados
- `PaddingFoundation` para padding
- `ColorFoundation` para colores

### Responsive

Usar `AdaptiveBottomBar` y widgets adaptativos que ya están implementados.

## 🧪 Testing

- Unit tests para usecases y repositorios
- Widget tests para pantallas y widgets
- Integration tests para flujos completos

## 🔒 Reglas Estrictas

1. **NO** crear providers sin `@riverpod` annotation
2. **NO** crear entidades/modelos sin `@freezed` annotation
3. **NO** usar textos hardcodeados, siempre usar `Translate`
4. **NO** mezclar lógica de negocio en presentación
5. **NO** acceder a datasources desde presentation
6. **SÍ** usar GetIt para todas las dependencias
7. **SÍ** seguir la estructura domain/data/presentation
8. **SÍ** crear register_dependencies.dart por feature
9. **SÍ** usar widgets foundation del proyecto
10. **SÍ** documentar código complejo con comentarios

## 🚀 Generación de Código

Después de crear entidades con `@freezed` o providers con `@riverpod`:

```bash
# Generar código
fvm flutter pub run build_runner watch --delete-conflicting-outputs --enable-experiment=dot-shorthands

# O en modo watch
fvm flutter pub run build_runner watch --delete-conflicting-outputs --enable-experiment=dot-shorthands
```

## 📚 Referencias

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Freezed Package](https://pub.dev/packages/freezed)
- [Riverpod Annotations](https://riverpod.dev/docs/concepts/about_code_generation)
- [GetIt](https://pub.dev/packages/get_it)
