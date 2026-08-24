#!/usr/bin/env python3
"""Configura versão e assinatura no projeto Android gerado pelo Capacitor."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


def version_data(version: str) -> tuple[str, int]:
    match = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", version.strip())
    if not match:
        raise ValueError(f"Versão inválida: {version!r}")
    major, minor, patch = (int(value) for value in match.groups())
    return version.strip(), major * 1_000_000 + minor * 1_000 + patch


def configure_text(source: str, version: str) -> str:
    version_name, version_code = version_data(version)

    configured, code_count = re.subn(
        r"(?m)^(\s*)versionCode\s+\d+\s*$",
        rf"\g<1>versionCode {version_code}",
        source,
        count=1,
    )
    configured, name_count = re.subn(
        r'(?m)^(\s*)versionName\s+["\'][^"\']+["\']\s*$',
        rf'\g<1>versionName "{version_name}"',
        configured,
        count=1,
    )
    if code_count != 1 or name_count != 1:
        raise RuntimeError("Não foi possível localizar versionCode/versionName no build.gradle")

    if "signingConfigs {" not in configured:
        android_marker = "android {"
        if android_marker not in configured:
            raise RuntimeError("Bloco android não encontrado no build.gradle")
        signing = """
    signingConfigs {
        release {
            storeFile file("smart-life-upload.jks")
            storePassword System.getenv("KEYSTORE_PASSWORD")
            keyAlias System.getenv("KEY_ALIAS")
            keyPassword System.getenv("KEY_PASSWORD")
        }
    }
"""
        configured = configured.replace(android_marker, android_marker + signing, 1)

    build_types_match = re.search(r"(?m)^\s*buildTypes\s*\{\s*$", configured)
    if not build_types_match:
        raise RuntimeError("Bloco buildTypes não encontrado no build.gradle")

    release_pattern = r"(?m)^(\s*)release\s*\{\s*$"
    build_types_source = configured[build_types_match.end():]
    release_match = re.search(release_pattern, build_types_source)
    if not release_match:
        raise RuntimeError("Bloco buildTypes.release não encontrado no build.gradle")
    release_indent = release_match.group(1)
    signing_line = f"{release_indent}    signingConfig signingConfigs.release"
    build_types_section = configured[build_types_match.start():]
    if "signingConfig signingConfigs.release" not in build_types_section:
        insertion_point = build_types_match.end() + release_match.end()
        configured = configured[:insertion_point] + "\n" + signing_line + configured[insertion_point:]

    return configured


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--gradle", required=True, type=Path)
    parser.add_argument("--version", required=True)
    args = parser.parse_args()

    source = args.gradle.read_text(encoding="utf-8")
    configured = configure_text(source, args.version)
    args.gradle.write_text(configured, encoding="utf-8")
    _, version_code = version_data(args.version)
    print(f"Android configurado: versionName={args.version}, versionCode={version_code}")


if __name__ == "__main__":
    main()
