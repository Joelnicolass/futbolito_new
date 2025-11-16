# 🐛 Soluciones a Errores y Bugs

Este documento recopila los errores encontrados durante el desarrollo y sus respectivas soluciones para referencia futura.

---

## 📋 Tabla de Contenidos

- [iOS - Crash al iniciar sesión con Google](#ios---crash-al-iniciar-sesión-con-google)
- [Android - Error al iniciar sesión con Google (ApiException: 10)](#android---error-al-iniciar-sesión-con-google-apiexception-10)

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

## Android - Error al iniciar sesión con Google (ApiException: 10)

### ❌ Error

```
PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10, null, null)
Exception: Error al iniciar sesión con Google: PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10, null, null)
```

**Síntomas:**

- Google Sign-In funciona correctamente en iOS
- En Android, al presionar "Continuar con Google" muestra el selector de cuentas
- Después de seleccionar una cuenta, falla con `ApiException: 10`
- El error `10` corresponde a `DEVELOPER_ERROR` en Google Play Services

### 🔍 Causa

El error ocurre porque el archivo `google-services.json` de Android **no contiene el Android Client ID** (oauth_client con `client_type: 1`).

Esto sucede cuando:

1. No se han configurado las **huellas digitales SHA-1 y SHA-256** en Firebase Console
2. El archivo `google-services.json` está desactualizado
3. Firebase no puede generar el Android OAuth Client sin las huellas digitales

**Archivo google-services.json incorrecto (solo tiene Web Client ID):**

```json
"oauth_client": [
  {
    "client_id": "...",
    "client_type": 3  // ❌ Solo Web Client (tipo 3)
  }
]
```

**Archivo google-services.json correcto (tiene Android + Web Client ID):**

```json
"oauth_client": [
  {
    "client_id": "...",
    "client_type": 1,  // ✅ Android Client (tipo 1)
    "android_info": {
      "package_name": "com.example.futbolitonew",
      "certificate_hash": "2e54a72a0711bd04aef02f467eb870673cf7aade"
    }
  },
  {
    "client_id": "...",
    "client_type": 3  // Web Client (tipo 3)
  }
]
```

### ✅ Solución

#### 1. Obtener las huellas digitales SHA-1 y SHA-256

Ejecutar desde la raíz del proyecto:

```bash
cd android && ./gradlew signingReport
```

Buscar la sección **Variant: debug** y copiar los valores:

```
SHA1: 2E:54:A7:2A:07:11:BD:04:AE:F0:2F:46:7E:B8:70:67:3C:F7:AA:DE
SHA-256: 6B:1D:A3:F7:BD:B9:15:56:49:28:66:7D:A1:F9:91:82:CF:BD:B5:91:89:9A:07:FB:61:B2:37:82:CF:D7:10:24
```

#### 2. Configurar las huellas en Firebase Console

1. Ir a [Firebase Console](https://console.firebase.google.com)
2. Seleccionar tu proyecto
3. Click en **⚙️ Project Settings**
4. Scroll down a **Your apps** y seleccionar tu app Android
5. En la sección **SHA certificate fingerprints**, click en **Add fingerprint**
6. Pegar el **SHA-1** (del keystore debug)
7. Click en **Add fingerprint** nuevamente
8. Pegar el **SHA-256**
9. Click en **Download google-services.json**

#### 3. Reemplazar el archivo google-services.json

Reemplazar el archivo `android/app/google-services.json` con el nuevo descargado de Firebase.

**Verificar que el nuevo archivo tenga el Android Client ID:**

```bash
cat android/app/google-services.json | grep -A 10 '"client_type": 1'
```

Deberías ver algo como:

```json
{
  "client_id": "487331532356-0e7eaqfrmasg3t5o28gkmnrj921a609k.apps.googleusercontent.com",
  "client_type": 1,
  "android_info": {
    "package_name": "com.example.futbolitonew",
    "certificate_hash": "2e54a72a0711bd04aef02f467eb870673cf7aade"
  }
}
```

#### 4. Limpiar y reconstruir

```bash
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
flutter run
```

### 🔑 Información Adicional

**Tipos de OAuth Client en google-services.json:**

- `client_type: 1` → Android Client (necesario para Google Sign-In en Android)
- `client_type: 2` → iOS Client
- `client_type: 3` → Web Client

**Para producción:**

Cuando publiques la app en Google Play, necesitarás agregar también las huellas SHA del **release keystore**:

```bash
keytool -list -v -keystore your-release-key.keystore -alias your-key-alias
```

Y agregar esas huellas en Firebase Console de la misma manera.

### 📚 Referencias

- [Google Sign-In for Android Setup](https://developers.google.com/identity/sign-in/android/start-integrating)
- [Firebase Console](https://console.firebase.google.com)
- [Google ApiException Status Codes](https://developers.google.com/android/reference/com/google/android/gms/common/api/CommonStatusCodes)
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
