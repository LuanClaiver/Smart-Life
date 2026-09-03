#!/usr/bin/env python3
"""Instala a integração nativa que salva relatorios, extratos e backups na pasta publica Downloads."""

from pathlib import Path
import shutil


ROOT = Path(__file__).resolve().parents[1]
NATIVE = ROOT / "android-native"
JAVA_TARGET = ROOT / "android/app/src/main/java/com/smartlife/app"
MANIFEST = ROOT / "android/app/src/main/AndroidManifest.xml"
PERMISSION = (
    '<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" '
    'android:maxSdkVersion="28" />'
)


def main() -> None:
    if not MANIFEST.exists():
        raise SystemExit("Projeto Android não encontrado. Execute 'npx cap add android' primeiro.")

    JAVA_TARGET.mkdir(parents=True, exist_ok=True)
    for filename in ("MainActivity.java", "SmartLifeDownloadsPlugin.java"):
        shutil.copy2(NATIVE / filename, JAVA_TARGET / filename)

    manifest = MANIFEST.read_text(encoding="utf-8")
    if PERMISSION not in manifest:
        marker = "<application"
        if marker not in manifest:
            raise SystemExit("AndroidManifest.xml inválido: tag <application> não encontrada.")
        manifest = manifest.replace(marker, f"    {PERMISSION}\n\n    {marker}", 1)
        MANIFEST.write_text(manifest, encoding="utf-8")

    print("Download nativo instalado: arquivos serao gravados em Downloads.")


if __name__ == "__main__":
    main()
