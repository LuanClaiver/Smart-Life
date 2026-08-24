# Publicar o Smart Life na Play Store

O projeto já inclui o workflow **Build Play Store AAB**, que gera o arquivo `.aab` assinado exigido pelo Google Play. Ele é manual para evitar criar versões de produção por engano; o APK de teste continua automático a cada envio para `main`.

## 1. Criar a chave de envio

No computador com Java instalado, execute uma única vez:

```bash
keytool -genkeypair -v -keystore smart-life-upload.jks -alias smart-life -keyalg RSA -keysize 2048 -validity 10000
```

Guarde o arquivo e as senhas em local seguro. A mesma chave deverá ser preservada para as próximas atualizações.

## 2. Configurar os segredos do GitHub

Converta o arquivo para Base64 e crie em **Settings → Secrets and variables → Actions**:

- `ANDROID_KEYSTORE_BASE64`: conteúdo Base64 do arquivo `.jks`.
- `KEYSTORE_PASSWORD`: senha do arquivo.
- `KEY_ALIAS`: alias usado no comando, por exemplo `smart-life`.
- `KEY_PASSWORD`: senha da chave.

## 3. Gerar o pacote

Abra **Actions → Build Play Store AAB → Run workflow**. Ao terminar, baixe o artefato `Smart-Life-v0.4.8-play-store-aab`.

Antes de publicar, revise a política de privacidade, os formulários de segurança de dados, os ícones, as capturas de tela e os requisitos atuais de teste do Google Play Console.

