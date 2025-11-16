# 🐛 Soluciones a Errores y Bugs

Este documento recopila los errores encontrados durante el desarrollo y sus respectivas soluciones para referencia futura.

---

## 📋 Tabla de Contenidos

- [iOS - Crash al iniciar sesión con Google](#ios---crash-al-iniciar-sesión-con-google)
- [Riverpod - Error con StateNotifier en Riverpod 3.x](#riverpod---error-con-statenotifier-en-riverpod-3x)
- [Freezed - Error de implementaciones faltantes](#freezed---error-de-implementaciones-faltantes)

---

## iOS - Crash al iniciar sesión con Google

### ❌ Error

```
Exception Type: EXC_CRASH (SIGABRT)
-[FLTGoogleSignInPlugin signInWithCompletion:]
-[GIDSignIn signInWithOptions:]
```

**Síntomas:**

- La app se cierra inmediatamente al presionar "Continuar con Google"
- Crash en iOS Simulator o dispositivo físico
- Error relacionado con `GoogleSignIn` framework

### 🔍 Causa

Falta la configuración del **URL Scheme** en `Info.plist`. Google Sign In necesita el `REVERSED_CLIENT_ID` configurado como URL Scheme para poder redirigir de vuelta a la app después de la autenticación.

### ✅ Solución

#### 1. Agregar URL Scheme en `Info.plist`

Editar `ios/Runner/Info.plist` y agregar:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.487331532356-ar3940o1ilkcc8hgnmocgqj4edlfjgd5</string>
        </array>
    </dict>
</array>
```

**Nota:** El valor debe ser el `REVERSED_CLIENT_ID` que se encuentra en `ios/Runner/GoogleService-Info.plist`.

#### 2. Actualizar `AppDelegate.swift`

Agregar el método para manejar URLs en `ios/Runner/AppDelegate.swift`:

```swift
override func application(
  _ app: UIApplication,
  open url: URL,
  options: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
  return super.application(app, open: url, options: options)
}
```

#### 3. Limpiar y reconstruir

```bash
cd ios && rm -rf Pods Podfile.lock && cd ..
fvm flutter clean
fvm flutter pub get
cd ios && pod install && cd ..
fvm flutter run
```

### 📚 Referencias

- [Google Sign-In for iOS Setup](https://developers.google.com/identity/sign-in/ios/start-integrating)
- [Flutter google_sign_in plugin](https://pub.dev/packages/google_sign_in)

---

### Checklist antes de reportar un bug

- [ ] ¿Se ejecutó `flutter clean` y `flutter pub get`?
- [ ] ¿Se generaron los archivos con `build_runner`?
- [ ] ¿Se recargó el IDE?
- [ ] ¿Se verificó la versión de Flutter con `fvm flutter --version`?
- [ ] ¿Se verificaron las dependencias en `pubspec.yaml`?

---

## 📝 Formato para agregar nuevos errores

Al agregar un nuevo error, usar este formato:

```markdown
## [Categoría] - Nombre del Error

### ❌ Error

Descripción del error y síntomas

### 🔍 Causa

Explicación de por qué ocurre

### ✅ Solución

Pasos detallados para resolverlo

### 📚 Referencias

Enlaces útiles
```

---

**Última actualización:** 2025-11-16
