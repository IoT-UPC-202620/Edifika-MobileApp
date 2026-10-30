# Edifika Mobile (residente)

App móvil Flutter de **Edifika** (startup Condomia) para residentes: propietarios (`OWNER`) e inquilinos (`TENANT`).

> **Estado real:** capa de datos lista y probada contra respuestas de la fake API. **Las pantallas aún no están implementadas**: están pendientes del inventario de diseño en Figma. La app solo muestra una pantalla temporal.

## Requisitos

- Flutter 3.38.x (stable), con el Dart que trae Flutter (`C:\src\flutter\bin`)
- Android SDK + emulador (AVD `Medium_Phone_API_36.1`)
- La fake API del repo web: [IoT-UPC-202620/FrontEnd](https://github.com/IoT-UPC-202620/FrontEnd) (`server/`)

## Cómo ejecutar

1. Levanta la fake API (en el repo web):
   ```powershell
   cd C:\Users\arian\Edifika-FrontEnd
   npm ci        # solo la primera vez
   npm run api   # http://localhost:3000
   ```
2. Arranca el emulador (tarea de VS Code **android: start emulator** o `emulator -avd Medium_Phone_API_36.1`).
3. Corre la app:
   ```powershell
   cd edifika_mobile
   flutter run -d emulator-5554
   ```

## Cambiar de fake API a microservicios

Hay un único punto de configuración, [`lib/core/config/app_config.dart`](lib/core/config/app_config.dart), equivalente a `environment.serverBaseUrl` del web:

```powershell
flutter run --dart-define=API_BASE_URL=https://<api-gateway>/api/v1
```

| Valor | Uso |
|---|---|
| `http://10.0.2.2:3000/api/v1` (por defecto) | Fake API en tu PC vista desde el emulador (`10.0.2.2` = `localhost` de la PC) |
| `https://<api-gateway>/api/v1` | API Gateway real, cuando exista |

Las rutas ([`api_endpoints.dart`](lib/core/config/api_endpoints.dart)) son las mismas que usa `environment.ts` del web. El tráfico HTTP sin TLS solo está permitido en **debug** y solo hacia `10.0.2.2`/`localhost` (`android/app/src/debug/res/xml/network_security_config.xml`).

**Cuentas de prueba (db.json):** `resident@edifika.com` (TENANT) y `owner@edifika.com` (OWNER). Las contraseñas están en `server/db.json` → `authentication`.

## Arquitectura

Organizada por feature, con capas `domain / data / presentation` (estilo DDD):

```
lib/
  app/                 composición de dependencias y MaterialApp/go_router
  core/
    config/            URL base + rutas de endpoints
    network/           Dio, interceptor de token/401, ApiException, parseList
    storage/           sesión cifrada (flutter_secure_storage)
  features/<feature>/
    domain/            modelos (freezed) + interfaz del repositorio
    data/              implementación HTTP del repositorio
```

- **Estado:** `flutter_bloc` (los cubits van con las pantallas).
- **HTTP:** `dio`. `AuthInterceptor` agrega `Bearer <token>`; ante un 401 con token cierra la sesión (igual que `authTokenInterceptor` del web).
- **Modelos:** `freezed` + `json_serializable`. Después de cambiar un modelo, vuelve a generar el código:
  ```powershell
  dart run build_runner build --force-jit --delete-conflicting-outputs
  ```
  (`--force-jit` es necesario: el modo AOT de build_runner falla con los paquetes que tienen build hooks).

## Integración por contexto

| Contexto / repositorio | Endpoints | Estado |
|---|---|---|
| Auth (`AuthRepository`) | `POST /authentication/sign-in` | ✅ Fake API |
| Residencial | `/residential/buildings/:id`, `/residential/units/:id`, `/residential/buildings/:id/residents` | ✅ Fake API |
| Pagos | `/payments/debts/unit/:unitId`, `/payments/user/:userId` | ✅ Fake API |
| Reservas | `/common-areas`, `/reservations`, `POST /reservations`, `POST /reservations/:id/cancelations` | ✅ Fake API (la disponibilidad se calcula en el cliente) |
| Foro | `GET/POST /posts` | ✅ Fake API (sin comentarios ni moderación) |
| Notificaciones | `/notifications/user/:userId`, `PATCH /notifications/:id/read` | ✅ Fake API (no hay notificaciones semilla para residentes) |
| Perfil | `GET/PUT /users/:id` | ✅ Fake API |
| Comunicados + confirmación de lectura | `/announcements`, `/announcement-reads` | ⛔ **Pendiente:** la fake API no tiene estas colecciones (hoy responde 404) |
| Registro | `POST /authentication/sign-up` | ⛔ **No expuesto:** la fake API asigna siempre el rol `ADMIN` |
| Comprobantes, pagos con Culqi, push con FCM, archivos con Cloudinary | — | ⛔ Pendiente (solo se dejarán interfaces y stubs) |

## Pruebas

```powershell
flutter analyze
flutter test
```

Las pruebas usan un `FakeHttpAdapter` en memoria con payloads copiados de `server/db.json`, así que no necesitan el servidor corriendo. **No reemplazan** una prueba contra la fake API en ejecución.

## Pantallas

| Pantalla | Estado |
|---|---|
| Todas (login, inicio, deudas/pagos, reservas, comunicados, notificaciones, foro, perfil) | Pendientes del diseño en Figma |
