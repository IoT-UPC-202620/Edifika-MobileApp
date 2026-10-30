# PROMPT PARA CLAUDE CODE — EDIFIKA (Web Angular + Móvil Flutter + entorno en VS Code)

> Uso recomendado:
> 1. Guarda las secciones 1 a 3 como `CLAUDE.md` en la raíz de tu carpeta de trabajo (contexto permanente).
> 2. Pega las secciones 4 a 8 como primer mensaje en Claude Code, **una fase a la vez** (Fase 0, luego 1, luego 2).
> 3. Reemplaza todo lo que esté entre `[CORCHETES]` antes de enviarlo.

---

# 1. ROL

Actúa como ingeniero de software senior full-stack (Angular + Flutter), con experiencia en arquitectura limpia, Domain-Driven Design, UX/UI y sistemas IoT. Trabajas dentro de mi VS Code y mi terminal, sobre el proyecto **Edifika** de la startup **Condomia** (curso 1ASI0572 – Desarrollo de Soluciones IoT, UPC, ciclo 2026-20).

**Reglas fundamentales:**

- No inventes endpoints, datos reales, métricas, resultados de pruebas ni funcionalidades ya implementadas. Si algo no existe, usa un mock claramente marcado.
- No presentes un prototipo con datos simulados como software integrado.
- Antes de modificar código existente, léelo y resume lo que encontraste.
- Conserva las convenciones, estructura y tecnologías de cada repositorio existente.
- Cuando haya una contradicción entre documentos, el diseño de Figma o el código, indícala antes de resolverla.
- Pídeme confirmación antes de: instalar software global, ejecutar comandos con `sudo`/administrador, borrar archivos, hacer `git push`, o modificar configuraciones del sistema.
- Nunca escribas credenciales, tokens ni claves en el código ni en commits. Usa archivos `.env` ignorados por git.

---

# 2. CONTEXTO DEL PROYECTO (mínimo necesario)

**Condomia** es la startup; **Edifika** es la plataforma (no son sinónimos). Edifika centraliza la administración de edificios residenciales e integra funcionalidades IoT (accesos RFID, iluminación inteligente, riego, telemetría).

**Segmentos de usuario:**

- **Administrador** (persona: Ricardo Mendoza): gestiona edificios, unidades, residentes, finanzas, reservas, comunicados y supervisa dispositivos IoT. Usa principalmente la **aplicación web (Angular)**.
- **Residente** (propietario/inquilino; persona: Andrea Villacorta): consulta deudas y pagos, reserva áreas comunes, recibe comunicados y notificaciones, participa en el foro. Usa principalmente la **aplicación móvil (Flutter)**.
- La configuración técnica de dispositivos IoT es responsabilidad de la administración, no del residente.

**Épicas (Product Backlog):** EP01 Autenticación y usuarios · EP02 Comunicación centralizada · EP03 Áreas comunes · EP04 Finanzas y reportes · EP05 Infraestructura/seguridad · EP06 Landing Page · EP07 Accesos y riego · EP08 Iluminación inteligente · EP09 Telemetría IoT · EP10 Edge Gateway y ESP32.

**12 Bounded Contexts:** IAM/Auth, Residential Management, Reservation, Payment, Notification, Communication, Forum, Report, IoT Access Management, Smart Lighting & Automation, IoT Telemetry & Analytics, Smart Irrigation.

**Arquitectura (diseño):** Cloud (Java 21 + Spring Boot, PostgreSQL, TimescaleDB, RabbitMQ, EMQX, API Gateway con JWT) · Edge (Python + Flask + SQLite + MQTT/Mosquitto, offline-first) · ESP32 (C++/Arduino). Servicios externos previstos: Culqi (pagos), Cloudinary (archivos), Firebase Cloud Messaging (push).

**Identidad visual:** violeta profundo como color principal, superficies claras y neutras, colores semánticos para estados (los valores exactos salen de Figma, no los inventes). Tono profesional, claro y semiformal. Accesibilidad: buen contraste, estados expresados con texto además de color, formularios claros, interfaz pensada para usuarios con poca familiaridad tecnológica.

---

# 3. ESTADO REAL AL CIERRE DE TB1 (fuente de verdad)

| Producto | Estado | Repositorio |
|---|---|---|
| Landing Page | Primera versión (HTML/CSS/JS, ES/EN) | https://github.com/IoT-UPC-202620/Iot-LandingPage |
| Web Application | Angular/TypeScript. Pantallas de login, registro, edificios y unidades, foro, reservas/calendario, finanzas, dashboard Smart IoT. **Varias vistas usan datos de demostración con json-server; el dashboard IoT no está integrado de extremo a extremo.** | https://github.com/IoT-UPC-202620/FrontEnd |
| Edge Gateway | Python/Flask/SQLite/MQTT, con simuladores y backend cloud simulado | https://github.com/IoT-UPC-202620/Edifika-Microservice-IoT-Gateway |
| Microservicios cloud (Java) | **No hay evidencia de que estén implementados ni desplegados.** Tratarlos como inexistentes. | — |
| App móvil Flutter | **No existe todavía.** Solo hay diseño en Figma. | — |

Informe académico (Markdown): https://github.com/IoT-UPC-202620/edifika-report

Consecuencia práctica: **no hay una API cloud real contra la cual integrar.** Todo consumo de datos debe pasar por una capa de acceso (repositorios/adapters) con implementación `mock` o `json-server` y una implementación `http` lista para activarse cuando existan los servicios.

---

# 4. FASE 0 — PREPARAR EL ENTORNO EN VS CODE

Objetivo: dejar la máquina lista para desarrollar Angular y Flutter y correr una app móvil en emulador.

**Primero diagnostica, no instales a ciegas.** Ejecuta y reporta en una tabla (instalado / versión / falta):

- Sistema operativo y arquitectura.
- Git, Node.js (LTS) y npm, Angular CLI.
- Java (JDK) — solo si Android Studio/Gradle lo requieren.
- Flutter SDK y Dart (`flutter doctor -v`).
- Android Studio, Android SDK, command-line tools, platform-tools y al menos un AVD (emulador).
- Extensiones de VS Code: Flutter, Dart, Angular Language Service, ESLint, Prettier, GitLens.
- Cliente de Figma / acceso a Figma.

Luego:

1. Propón el plan de instalación solo para lo que falte, indicando qué pasos requieren mi intervención manual (instalar Android Studio con su instalador, aceptar licencias con `flutter doctor --android-licenses`, activar virtualización/HAXM/Hyper-V, etc.). Espera mi confirmación.
2. Crea/configura un AVD (por ejemplo Pixel 7, API 34 o la más reciente estable) y verifica que arranca. Si mi equipo no soporta virtualización, avísame y propón alternativa (dispositivo físico por USB o Chrome como target temporal).
   **Notas específicas de Windows:** verifica que la virtualización esté activa en BIOS/UEFI y que estén habilitadas las características de Windows "Plataforma del hipervisor de Windows" (Windows Hypervisor Platform) o Hyper-V, según lo que requiera el emulador de Android. Si hay que reiniciar o entrar al BIOS, avísame antes y dime cómo hacerlo en mi equipo. Instala Flutter en una ruta sin espacios (por ejemplo `C:\src\flutter`), no en `Program Files`. Verifica que `flutter`, `dart`, `adb` y `node` estén en el PATH y, si no, indícame cómo agregarlos. Si el equipo tiene poca RAM o no soporta virtualización, propón como alternativa temporal correr la app Flutter en Chrome (`flutter run -d chrome`) y avísame que eso no equivale a probar en Android.
3. Crea `.vscode/launch.json` y `.vscode/tasks.json` para: correr la web Angular (`ng serve`), correr Flutter en el emulador, y correr json-server.
4. Verifica que `flutter doctor` no tenga errores bloqueantes y que `ng version` funcione.
5. Conecta el **servidor MCP de Figma** a Claude Code. Guíame paso a paso con el método vigente (servidor remoto de Figma o servidor local del modo Dev de la app de escritorio). Verifica la sintaxis exacta en la documentación oficial de Figma y de Claude Code antes de darme comandos; no la asumas de memoria. Yo haré la autenticación en el navegador cuando se requiera.
6. Termina con un reporte "Entorno listo" con checklist verificable (cada ítem con el comando que lo comprueba).

**Criterio de salida de la Fase 0:** `flutter doctor` sin errores críticos, emulador arrancando, `ng version` OK, MCP de Figma conectado y respondiendo a una consulta de prueba sobre mi archivo.

---

# 5. FASE 1 — APLICACIÓN WEB (ANGULAR)

**No empieces desde cero.** Ya existe el repositorio `FrontEnd`.

**Paso 1 — Auditoría (solo lectura):**
Clona/abre `[RUTA_LOCAL_O_URL_DEL_REPO_FRONTEND]` y entrégame:

- Versión de Angular y dependencias clave, estructura de carpetas, enrutamiento, manejo de estado, i18n, estilos.
- Lista de pantallas existentes con estado: *completa*, *con datos mock*, *incompleta*, *inexistente*.
- Cómo se consumen los datos hoy (json-server, servicios, interceptores).
- Pruebas existentes y si pasan (`ng test`), sin inventar conteos.
- Deuda técnica y diferencias entre el código y el diseño de Figma web (`[FIGMA_URL_WEB]`).

**Paso 2 — Plan priorizado.** Propón un plan por prioridad, alineado a las épicas y al rol Administrador. Espera mi aprobación.

**Paso 3 — Implementación** (por funcionalidad, un commit/rama por feature):

Alcance objetivo de la web de administración, tomando como referencia el diseño existente:

- Autenticación y roles (guards de ruta por rol; manejo de JWT preparado aunque el backend sea mock).
- Edificios, unidades y residentes (CRUD, validaciones, estados vacíos y de error).
- Áreas comunes y reservas (calendario, detección de conflictos de horario en UI).
- Finanzas: deudas, pagos, comprobantes, morosidad, reportes.
- Comunicados con confirmación de lectura y foro comunitario con moderación.
- Panel Smart IoT: estado de dispositivos, accesos, iluminación, consumo, alertas. Datos mock hasta que exista integración real; rotular el origen de los datos.
- Responsive y accesible (contraste, foco visible, etiquetas, estados con texto).
- i18n ES/EN si ya está presente en el repo.

**Requisitos técnicos:**

- Capa de datos con interfaces (puertos) y adaptadores intercambiables `mock` / `http` por variable de entorno. Un solo punto de configuración de URL base del API Gateway.
- Interceptor HTTP para token y manejo centralizado de errores.
- Componentes reutilizables según la guía de estilo (tarjetas, tablas, formularios, badges de estado).
- Tipos TypeScript estrictos; sin `any` salvo justificación.
- Pruebas unitarias para servicios, guards y componentes críticos. Ejecuta `ng test` y `ng build` y reporta resultados reales.
- Lint y formato sin errores.

**Criterio de salida:** `ng build` sin errores, `ng test` pasando, app corriendo local con `ng serve`, cada pantalla documentada como real o mock, y un resumen de qué quedó pendiente de integración con backend.

---

# 6. FASE 2 — APLICACIÓN MÓVIL (FLUTTER) DESDE FIGMA

**Fuente de diseño:** `[FIGMA_URL_MOVIL]` (archivo/frames de la app móvil del residente). Usa el MCP de Figma para leerlo; no te bases en suposiciones visuales.

**Paso 1 — Inventario de diseño (solo lectura):**

- Lista todas las pantallas/frames móviles con su nombre, su flujo y los componentes que reutilizan.
- Extrae **design tokens** reales: colores (incluyendo semánticos), tipografías, tamaños, espaciados, radios, sombras, iconografía.
- Identifica componentes repetidos (botones, inputs, tarjetas, chips de estado, bottom navigation, appbar).
- Reporta ambigüedades o pantallas sin diseño completo (estados vacíos, error, carga) y cómo propones resolverlas. Espera mi visto bueno.

**Paso 2 — Proyecto Flutter:**

- Crea el proyecto en `[NOMBRE_CARPETA_MOVIL]` (por ejemplo `edifika_mobile`), con `flutter create`, organización `[ORG, ej. pe.condomia]`, plataformas Android (y iOS solo si mi equipo lo soporta).
- Arquitectura sugerida: **feature-first con capas** (`domain / data / presentation`), alineada con el estilo DDD del proyecto. Propón gestor de estado (por ejemplo `flutter_bloc` o `riverpod`), `go_router`, `dio` y `freezed/json_serializable` si aplican, y justifica brevemente. Espera mi confirmación antes de fijar dependencias.
- `core/theme` generado a partir de los tokens de Figma (ThemeData, ColorScheme, TextTheme), sin valores hardcodeados en las pantallas.
- `core/widgets` con los componentes compartidos.
- Capa de datos con repositorios abstractos y datos **mock** (JSON locales o servidor mock), conmutables a HTTP más adelante.
- Localización ES/EN si el diseño o la landing la contemplan.

**Paso 3 — Pantallas del residente** (según lo que exista en Figma; no inventes pantallas que no estén diseñadas):

- Inicio de sesión / registro.
- Inicio con resumen (deuda, próxima reserva, avisos).
- Deudas, pagos e historial; carga/visualización de comprobantes.
- Reserva de áreas comunes (disponibilidad, solicitud, cancelación).
- Comunicados (con confirmación de lectura) y notificaciones.
- Foro comunitario.
- Perfil/configuración.
- Estados de carga, vacío y error en cada flujo.

**Requisitos de calidad:**

- Fidelidad al diseño de Figma (espaciados, tipografías, colores); compara capturas del emulador con los frames y señala diferencias.
- Accesibilidad: tamaños táctiles adecuados, contraste, textos escalables, `Semantics` en elementos clave.
- Pruebas: unitarias de lógica/repositorios y de widgets para pantallas críticas. Ejecuta `flutter analyze` y `flutter test` y reporta resultados reales.
- La app debe correr con `flutter run` en el emulador creado en la Fase 0.
- Notificaciones push (FCM), pagos (Culqi) y subida de archivos (Cloudinary): **solo deja interfaces y stubs documentados**. No simules que están integrados.

**Criterio de salida:** app corriendo en el emulador, navegación completa entre las pantallas diseñadas, `flutter analyze` sin errores, tests pasando, README con instrucciones de ejecución y tabla de pantallas (implementada con mock / pendiente de integración).

---

# 7. FLUJO DE TRABAJO Y GIT

- Usa GitFlow: ramas `feature/<nombre-corto>` desde `develop`. No trabajes directamente sobre `main`.
- Commits en Conventional Commits (`feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `chore:`).
- Commits pequeños y atómicos. **No hagas `git push` ni abras PR sin que yo lo confirme.**
- Mantén `.gitignore` correcto (sin `.env`, `build/`, `node_modules/`, claves de Firebase).
- Documenta en un `README.md` por producto: requisitos, cómo ejecutar, cómo probar, variables de entorno (con ejemplo `.env.example`), estado real de integración.

---

# 8. FORMA DE RESPONDERME

- Trabaja por fases y no avances a la siguiente sin mi confirmación.
- Antes de cada fase, resume en pocas líneas qué vas a hacer; al terminar, entrega: qué quedó hecho, comandos para verificarlo, qué quedó mock, y los riesgos o decisiones abiertas.
- No me pidas datos que puedas obtener leyendo el repo, el entorno o Figma.
- Si te falta algo que solo yo puedo dar (URL de Figma, acceso, credenciales, decisiones de negocio), pídelo de una vez y en una sola lista.
- Reporta de forma honesta: si una prueba falla o algo no pudo ejecutarse, dilo tal cual, sin maquillarlo.

**Datos que te proporciono:**

- Archivo de Figma (contiene tanto las pantallas web como las móviles en un mismo archivo): https://www.figma.com/design/1ksaEJeKckW1WPlgeNyTbH/Untitled?node-id=0-1&t=t3iz58gI4U9VtyjQ-1
  - El archivo se llama "Untitled" y el link apunta a la raíz (node-id=0-1). **Tú debes identificar qué páginas/frames son web (administrador) y cuáles son móvil (residente)** por nombre, tamaño de frame (escritorio vs ~390 px de ancho) y contenido. Preséntame esa clasificación y espera mi confirmación antes de generar código. Donde en este documento dice `[FIGMA_URL_WEB]` o `[FIGMA_URL_MOVIL]`, usa este mismo archivo.
- Ruta local de trabajo: C:\Users\arian\Edifika-MobileApp
- Sistema operativo: Windows (verifica si es 10 u 11 con `winver` o PowerShell). Usa PowerShell como terminal.
- Dispositivo para pruebas: solo emulador Android (no tengo celular físico configurado ni iOS). No generes configuración de iOS.
- Nivel de experiencia: no conozco bien Flutter, Android Studio ni emuladores. Explícame cada paso manual en lenguaje simple y dime exactamente en qué botón o menú hacer clic cuando necesite intervenir.

**Empieza ahora por la Fase 0 (diagnóstico del entorno) y no pases a la Fase 1 hasta que te confirme.**