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

**Cuentas de prueba (`server/db.json` → `authentication`):** `resident@edifika.com` (TENANT) y `owner@edifika.com` (OWNER). Las cuentas `ADMIN` entran a la **Gestión IoT** (ver abajo); con la fake API esa pantalla muestra un aviso porque json-server no tiene rutas IoT.

## Roles

| Rol | Navegación en la app |
|---|---|
| `OWNER`, `TENANT` | Pestañas del residente (Inicio, Cuenta, Reservas, Anuncios, Comunidad) |
| `ADMIN` | Solo **Gestión IoT** (`/admin/iot`), sin la barra del residente |
| Sin rol habilitado | Rechazado en el login |

El IAM real responde a `sign-in` solo `{ id, email, token }`; los roles se leen del claim `roles` del JWT (con o sin el prefijo `ROLE_`). La fake API sí los envía en el cuerpo. El router mantiene a cada rol dentro de su navegación.

## Gestión IoT (administrador)

Pantalla para supervisar los dispositivos IoT de un edificio y registrar sus tarjetas RFID. No tiene diseño en Figma: usa los tokens y componentes de la app.

- **Edificio:** selector con `GET /residential/buildings` (acepta `id` de la fake API o `idBuilding` del microservicio).
- **Resumen:** dispositivos En línea / Sin conexión / Mantenimiento / Por activar.
- **Gateways y dispositivos:** cada gateway del edificio con su estado y última sincronización, y debajo sus dispositivos con estado, última conexión y últimas lecturas (temperatura y humedad del DHT11).
- **Detalle del dispositivo** (`/admin/iot/device`): estado, firmware, modo de acceso, reserva activa, segundos de apertura, color del LED, sensores, componentes del nodo ESP32 (RFID RC522, cerradura por relé, buzzer, OLED, LED RGB, DHT11) y gateway.

| Dato | Endpoint (rol ADMIN) | Servicio |
|---|---|---|
| Gateways del edificio | `GET /iot/gateways?buildingId=` | IoT Access Management |
| Dispositivos del edificio | `GET /iot/devices?buildingId=` | IoT Access Management |
| Telemetría | `GET /telemetry/devices?buildingId=` | IoT Telemetry (si falla, se muestran los dispositivos sin lecturas) |

El gateway del edificio se registra en el backend (`POST /iot/gateways`); los dispositivos se descubren y adoptan desde la app (ver abajo). Abrir la puerta y el modo mantenimiento quedan para una próxima versión.

### Dispositivos nuevos (descubrimiento y adopción)

Los nodos ESP32 ya no se registran a mano en el backend:

1. Al encenderse, el nodo se anuncia en el broker. Su gateway lo identifica y aparece en **Gestión IoT** como "N dispositivos nuevos" (`/admin/iot/discovered`). Mientras tanto la pantalla del nodo muestra `Sin registrar` y un código de 4 dígitos, y el nodo no opera.
2. En **Adoptar dispositivo** (`/admin/iot/adopt`) se comprueba que el código coincida con el de la pantalla. **Identificar** hace parpadear y sonar la placa; luego se completan nombre, ubicación, segundos de apertura y componentes (vienen marcados según lo que anunció el nodo).
3. **Adoptar** crea el dispositivo en el gateway que lo identificó. En unos segundos el nodo recibe su configuración, deja de mostrar el código y queda En línea. **Ignorar** lo saca de la lista.

| Acción | Endpoint (rol ADMIN) |
|---|---|
| Dispositivos nuevos del edificio | `GET /iot/discovered-devices?buildingId=` |
| Identificar | `POST /iot/discovered-devices/{id}/identify` |
| Adoptar | `POST /iot/discovered-devices/{id}/adopt` |
| Ignorar | `POST /iot/discovered-devices/{id}/ignore` |

### Tarjetas RFID

Todo el registro de tarjetas se hace desde el teléfono, con la sesión de administrador:

1. **Gestión IoT → Tarjetas RFID** (`/admin/iot/cards`): lista las tarjetas del edificio con titular, email, rol y estado (filtros Todas / Activas / Inactivas).
2. **Leer tarjeta en un lector:** se elige el lector en línea (si hay uno solo, se abre directo). El detalle del dispositivo entra en **modo registro** durante 60 s: el LED del nodo se pone cian, el OLED muestra `MODO REGISTRO` y la puerta no se abre.
3. Al acercar la tarjeta, la app muestra el UID capturado y una lista de usuarios: primero los residentes del edificio y después el resto. Queda elegido de entrada el primero que no es solo administrador (por ejemplo, el propietario por defecto).
4. **Asociar** crea la credencial (`POST /access/credentials`), el gateway se resincroniza y la tarjeta abre la puerta.
5. Tocando una tarjeta de la lista se puede **suspender, reactivar, marcar como perdida o revocar** (`PATCH /access/credentials/{id}/status`). Una tarjeta revocada o perdida se puede volver a leer y asignar a otro usuario.

| Acción | Endpoint (rol ADMIN) |
|---|---|
| Modo registro | `POST` / `GET` / `DELETE /iot/devices/{id}/enrollment` |
| Tarjetas del edificio | `GET /access/credentials?buildingId=` |
| Asociar tarjeta | `POST /access/credentials` |
| Cambiar estado | `PATCH /access/credentials/{id}/status` |

**Usuarios por defecto** (los crea el IAM al arrancar si no existen):

| Rol | Email | Contraseña |
|---|---|---|
| Administrador | `admin@edifika.com` | `Edifika#2026` |
| Propietario | `propietario@edifika.com` | `Edifika#2026` |

Se cambian con `SEED_ADMIN_EMAIL`, `SEED_ADMIN_PASSWORD`, `SEED_OWNER_EMAIL` y `SEED_OWNER_PASSWORD`, y el seed se desactiva con `SEED_DEFAULT_USERS=false`.

Para probarla en vivo hay que apuntar a los microservicios: `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api/v1` (API Gateway local). Los modelos siguen `Edifika-IoT-Platform/contracts` y las pruebas usan sus ejemplos.

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
