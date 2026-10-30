# Edifika Mobile (residente)

App móvil Flutter de **Edifika** (startup Condomia) para residentes: propietarios (`OWNER`) e inquilinos (`TENANT`).

> **Estado real:** las 12 pantallas del diseño móvil están implementadas y consumen la **fake API del repo web** (json-server). Comunicados, respuestas del foro, foros temáticos, comprobantes y recuperación de contraseña se muestran como **"Pendiente de integración"**: la fake API no los tiene y no se simulan datos.

## Requisitos

- Flutter 3.38.x (stable), con el Dart que trae Flutter (`C:\src\flutter\bin`)
- Android SDK + emulador (AVD `Medium_Phone_API_36.1`)
- La fake API del repo web: [IoT-UPC-202620/FrontEnd](https://github.com/IoT-UPC-202620/FrontEnd) (`server/`)

## Cómo ejecutar

1. Levanta la fake API (en el repo web):
   ```powershell
   cd C:\Users\arian\Edifika-FrontEnd
   npm ci --ignore-scripts   # solo la primera vez
   npm run api               # http://localhost:3000
   ```
   > En local la fake API **escribe en `server/db.json`** del repo web. Para descartar los datos de prueba: `git checkout -- server/db.json`.
2. Arranca el emulador (tarea de VS Code **android: start emulator** o `emulator -avd Medium_Phone_API_36.1`).
3. Corre la app:
   ```powershell
   cd edifika_mobile
   flutter run -d emulator-5554
   ```

**Cuentas de prueba (`server/db.json` → `authentication`):** `resident@edifika.com` (TENANT) y `owner@edifika.com` (OWNER). Las cuentas `ADMIN` son rechazadas: la administración usa la app web.

## Cambiar de fake API a microservicios

Hay un único punto de configuración, [`lib/core/config/app_config.dart`](lib/core/config/app_config.dart), equivalente a `environment.serverBaseUrl` del web:

```powershell
flutter run --dart-define=API_BASE_URL=https://<api-gateway>/api/v1
```

| Valor | Uso |
|---|---|
| `http://10.0.2.2:3000/api/v1` (por defecto) | Fake API en tu PC vista desde el emulador (`10.0.2.2` = `localhost` de la PC) |
| `https://<api-gateway>/api/v1` | API Gateway real, cuando exista |

Las rutas ([`api_endpoints.dart`](lib/core/config/api_endpoints.dart)) son las mismas que usa `environment.ts` del web. El tráfico HTTP sin TLS solo está permitido en **debug** y solo hacia `10.0.2.2`/`localhost`.

## Pantallas

| # Figma | Pantalla | Ruta | Datos |
|---|---|---|---|
| 01 | Login | `/login` | ✅ fake API ("Recuperar contraseña": pendiente) |
| 02 | Inicio | `/home` | ✅ deuda, próxima reserva, notificaciones · ⛔ anuncios pendientes |
| 03 | Mis deudas | `/account` | ✅ |
| 04 | Mis pagos | `/account/payments` | ✅ pagos · ⛔ comprobante PDF pendiente |
| 05 | Reservas | `/reservations` | ✅ áreas, próximas y pasadas |
| 06 | Nueva reserva | `/reservations/new` | ✅ disponibilidad, reglas, conflictos |
| 07 | Reserva confirmada / detalle | `/reservations/detail` | ✅ incluye cancelación |
| 08 | Notificaciones | `/home/notifications` | ✅ marcar leída / todas |
| 09 | Anuncios | `/announcements` | ⛔ pendiente (la fake API responde 404) |
| 10 | Comunidades | `/community` | ✅ temas, búsqueda · ⛔ foros temáticos pendientes |
| 11 | Tema del foro | `/community/post` | ✅ publicación · ⛔ respuestas pendientes |
| 12 | Nueva publicación | `/community/new` | ✅ publicar · ⛔ adjuntar imagen (Cloudinary) pendiente |
| — | Hoja "Mi cuenta" (avatar en Inicio) | — | Datos de la cuenta y **cerrar sesión** (no hay pantalla de perfil en Figma) |

Todas las pantallas tienen estados de **carga, vacío y error con reintento** (Figma no los diseña; se usan los mismos tokens).

## Decisiones de diseño y contrato

- **Moneda:** se muestra la que envía la API (`S/` para PEN), aunque Figma use `$`.
- **Reserva por rango vs. `timeSlot`:** un rango de N horas crea N reservas de 1 hora. Si una falla (409), las ya creadas se cancelan. En pantalla, las horas consecutivas se agrupan en un bloque ("10:00–12:00"). La disponibilidad se calcula en el cliente con la misma regla de duplicados de la fake API (no existe `/reservations/availability`).
- **Notificaciones:** se usa la forma real de la fake API (`id`, `content`, `read`, `createdAt`), no el modelo `Notification` del web. El ícono y el enlace se deducen del título (la API no envía el tipo).
- **Recordar sesión:** desmarcado, la sesión vive solo en memoria.
- **Recarga entre pestañas:** las pestañas conservan su estado; los repositorios emiten `DataChanges` tras cada escritura y Inicio/Reservas se recargan en silencio.
- **Tipografía:** fuente del sistema (Roboto). Figma parece usar Inter, pero no se confirmó (límite de llamadas del MCP de Figma) y no se agregó la dependencia.
- **Login:** la foto del edificio del mockup se reemplazó por un degradado (no se exportó el asset). El logo es un vector dibujado a partir del isotipo de Figma.

## Arquitectura

Feature-first con capas `domain / data / presentation` (estilo DDD):

```
lib/
  app/                 dependencias, MaterialApp, rutas (go_router + barra de 5 pestañas)
  core/
    config/            URL base + rutas de endpoints
    events/            DataChanges + mixin ReloadOnDataChanges
    network/           Dio, interceptor de token/401, ApiException, parseList
    storage/           sesión (memoria + flutter_secure_storage)
    theme/             tokens medidos en Figma + ThemeData
    utils/             formatos es-PE, LoadStatus
    widgets/           AppCard, StatusChip, ScreenScaffold, estados, logo…
  features/<feature>/
    domain/            modelos (freezed) + interfaz del repositorio
    data/              implementación HTTP del repositorio
    presentation/      cubits (flutter_bloc) + pantallas
```

- **Estado:** `flutter_bloc` (cubits con estados `freezed`). **HTTP:** `dio`. **Rutas:** `go_router` con `StatefulShellRoute`. **Fechas:** `intl` + `flutter_localizations` (es-PE).
- Después de cambiar un modelo o un estado `freezed`:
  ```powershell
  dart run build_runner build --force-jit --delete-conflicting-outputs
  ```
  (`--force-jit` es necesario: el modo AOT de build_runner falla con los paquetes que tienen build hooks).

## Pruebas

```powershell
flutter analyze
flutter test
```

- **Unitarias:** cliente HTTP (token, 401, errores), repositorios con payloads copiados de `db.json`, cubits de login, inicio y reservas (validaciones, rango de varias horas, reversión ante 409, recarga silenciosa).
- **Widgets:** Mis deudas (chips en texto, estado vacío) y **navegación de la app completa** (router real + HTTP simulado): pestañas, Inicio → detalle de reserva → volver, Inicio → Mis pagos → atrás.
- **Manual contra la fake API en el emulador:** login TENANT, Inicio, crear reserva de 2 horas, cancelarla, Mis deudas, crear publicación.

## Integración pendiente

| Funcionalidad | Qué falta |
|---|---|
| Comunicados + confirmación de lectura | Colecciones `announcements` / `announcement-reads` en la API (el repositorio ya existe) |
| Respuestas y foros temáticos | Modelo y endpoints en el servicio de foro |
| Comprobantes de pago, pagos (Culqi) | Endpoints de comprobantes; pasarela |
| Adjuntar imágenes (Cloudinary), push (FCM) | Solo interfaz; sin integración |
| Recuperar contraseña | Endpoint en IAM |
| Registro de residentes | La fake API asigna siempre `ADMIN` en `sign-up` |
