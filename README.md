# BearScreenDimmer

Una aplicación macOS simple que crea overlays transparentes para oscurecer la pantalla. Perfecta para reducir el brillo de la pantalla sin afectar el contenido.

## 🚀 Descarga

**Descarga directa:** [BearScreenDimmer_v1.0.dmg](BearScreenDimmer_v1.0.dmg)

O visita la página web: [index.html](index.html)

## Características

- 🐻 Icono de oso en la barra de estado
- ✨ Overlays transparentes personalizables
- 🎛️ Modo de edición para ajustar transparencia
- 📱 Múltiples ventanas de overlay
- 🔒 Modo normal (no interactivo) y modo edición
- 🌐 Visible en todos los espacios de trabajo
- 🎥 No aparece en grabaciones de pantalla

## Instalación

1. Descarga el archivo `BearScreenDimmer_v1.0.dmg`
2. Abre el DMG y arrastra la aplicación a tu carpeta Applications
3. Ejecuta la aplicación desde Applications

## Uso

1. **Iniciar la aplicación:** La aplicación se ejecuta en segundo plano y aparece un icono de oso en la barra de estado.

2. **Crear overlay:** Haz clic en el icono de la barra de estado y selecciona "+ New Overlay"

3. **Modo edición:** 
   - Selecciona "Edit Mode: ON" para poder mover y redimensionar las ventanas
   - Ajusta la transparencia con el slider
   - Haz clic en el icono de la barra de estado para salir del modo edición

4. **Salir:** Selecciona "Quit" desde el menú de la barra de estado

## Estructura del Proyecto

```
BearScreenDimmer/
├── BearScreenDimmerApp.swift    # Punto de entrada de la aplicación
├── AppDelegate.swift            # Delegado principal y lógica de la barra de estado
├── OverlayContentView.swift     # Vista del contenido del overlay
├── bear-icon.svg               # Icono del oso (SVG)
├── Package.swift               # Configuración del paquete Swift
├── index.html                  # Página web para descarga
├── BearScreenDimmer_v1.0.dmg   # Instalador de la aplicación
└── README.md                   # Este archivo
```

## Distribución

La aplicación está lista para distribución:

- **`BearScreenDimmer_v1.0.dmg`** - Instalador completo (172KB)
- **`index.html`** - Página web para descarga

## Notas Técnicas

- **Versión mínima:** macOS 13.0
- **Arquitectura:** x86_64 (Intel)
- **Bundle ID:** com.bearscreendimmer.app
- **Tipo:** Aplicación de barra de estado (LSUIElement)
- **Tamaño:** ~5MB instalado

## Licencia

Este proyecto es de código abierto. Siéntete libre de modificarlo y distribuirlo.
