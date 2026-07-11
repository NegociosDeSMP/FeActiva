# FeActiva

Proyecto Flutter base para una app católica juvenil.

## Incluye
- Modo oscuro por defecto
- Tarjetas interactivas
- Evangelio del día
- Reto espiritual aleatorio
- Oraciones rápidas
- Buscador de versículos
- Música de fondo como asset local
- Estructura lista para ampliar la Biblia completa

## Importante
Este proyecto está preparado para que **Codemagic genere la carpeta Android automáticamente** al compilar con:

```bash
flutter create --platforms=android .
flutter pub get
flutter build apk --release
```

## Qué subir a GitHub
Sube toda esta carpeta del proyecto, no solo el ZIP. Debe incluir:
- `lib/`
- `assets/`
- `pubspec.yaml`
- `codemagic.yaml`
- `.gitignore`
- `README.md`

## Cómo compilar el APK con Codemagic
1. Sube el proyecto completo a GitHub.
2. Entra a Codemagic y conecta tu repositorio.
3. Busca el workflow `feactiva_android_release`.
4. Ejecuta la compilación.
5. Descarga el archivo:
   `build/app/outputs/flutter-apk/app-release.apk`

## Cómo probarlo antes de publicar
En una PC con Flutter:
```bash
flutter create --platforms=android .
flutter pub get
flutter run
```

## Nota importante
`assets/bible/sample_bible.json` contiene solo versos de ejemplo.
Cuando quieras la Biblia completa, reemplázalo por un JSON completo o por SQLite.
