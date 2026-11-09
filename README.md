# Implementación de persistencia local y sincronización en modo offline para una aplicación de pagos

La aplicación de pagos debe soportar operaciones sin conexión, permitiendo al usuario realizar transacciones que se almacenarán localmente y se sincronizarán con el servidor una vez que la conexión sea restablecida. Los actores involucrados son el Usuario, el Servicio de Pagos y el Almacenamiento Local. La aplicación debe manejar el estado y los flujos asincrónicos con persistencia local, asegurando que las transacciones se completen correctamente una vez que la conexión se restablezca.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | persistencia local y modo offline (reg 1109) |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 2 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Diseño del modelo de persistencia local

**Objetivo:** Definir la estructura de datos para la persistencia local y establecer las reglas para la sincronización posterior.

**Tiempo estimado:** 3 días

**Instrucciones:**

- Identificar los datos que deben persistir localmente durante la falta de conexión.
- Establecer las reglas para la sincronización de datos una vez que la conexión sea restablecida.
- Considerar los posibles casos de conflicto y cómo resolverlos.

**Entregable:** Modelo de datos para persistencia local y reglas de sincronización.

<details>
<summary>Pistas de conocimiento</summary>

- Pistas sobre cómo estructurar datos para persistencia local.
- Estrategias para manejar conflictos de sincronización.

</details>

### Fase 2: Implementación de la persistencia local

**Objetivo:** Implementar la funcionalidad para almacenar transacciones localmente cuando no hay conexión.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Desarrollar la lógica para almacenar transacciones en el almacenamiento local.
- Asegurar que las transacciones se guarden de manera segura y se puedan recuperar posteriormente.
- Implementar mecanismos para detectar la falta de conexión y redirigir las operaciones a la persistencia local.

**Entregable:** Implementación de la funcionalidad de persistencia local para transacciones.

<details>
<summary>Pistas de conocimiento</summary>

- Técnicas para asegurar la integridad de los datos almacenados localmente.
- Métodos para detectar cambios en el estado de la conexión.

</details>

### Fase 3: Sincronización de datos con el servidor

**Objetivo:** Implementar la lógica para sincronizar los datos almacenados localmente con el servidor una vez que la conexión sea restablecida.

**Tiempo estimado:** 4 días

**Instrucciones:**

- Desarrollar la lógica para enviar las transacciones almacenadas localmente al servidor.
- Implementar mecanismos para resolver conflictos de sincronización.
- Asegurar que la sincronización se realice de manera eficiente y sin interrumpir la experiencia del usuario.

**Entregable:** Implementación de la funcionalidad de sincronización de datos con el servidor.

<details>
<summary>Pistas de conocimiento</summary>

- Estrategias para optimizar el proceso de sincronización.
- Métodos para manejar conflictos de datos durante la sincronización.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es la persistencia local y cómo se relaciona con la operación sin conexión en la aplicación de pagos?
- **paraQueSirve**: ¿Para qué sirve la sincronización de datos una vez que la conexión es restablecida?
- **comoSeUsa**: ¿Cómo se usa la persistencia local para almacenar transacciones durante la falta de conexión?
- **erroresComunes**: ¿Cuáles son los errores comunes que pueden ocurrir durante la persistencia local y la sincronización de datos?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño del modelo de datos para la persistencia local y la sincronización?

## Criterios de Evaluacion

- Definición clara del modelo de datos para persistencia local.
- Implementación correcta de la funcionalidad de persistencia local para transacciones.
- Implementación efectiva de la sincronización de datos con el servidor.
- Manejo adecuado de conflictos de sincronización.
- Optimización del proceso de sincronización para minimizar el impacto en la experiencia del usuario.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
flutter pub get && flutter analyze
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
