# Publicar o Smart Life na Play Store

O projeto já inclui o workflow **Build Play Store AAB**, que gera o arquivo `.aab` assinado exigido pelo Google Play. Ele é manual para evitar criar versões de produção por engano; o APK de teste continua automático a cada envio para `main`.

Para criar a assinatura sem instalar Java no computador, siga primeiro **ASSINATURA-GITHUB.md**. Esse é o método recomendado para este projeto.

## 1. Criar a chave de envio

No computador com Java instalado, execute uma única vez:

```bash
keytool -genkeypair -v -keystore smart-life-upload.jks -alias smart-life -keyalg RSA -keysize 2048 -validity 10000
```

Guarde o arquivo e as senhas em pelo menos dois locais seguros. A mesma chave deverá ser preservada para todas as próximas atualizações do APK e da Play Store.

No Windows, você também pode abrir a pasta **Arquivos GitHub (Ignore) → Dados pessoais - NÃO ENVIAR** e executar **Configurar assinatura Android.bat**. O assistente cria a chave e o texto Base64 sem colocar esses dados no repositório. Se o Java não estiver instalado, ele baixa automaticamente o Eclipse Temurin JDK 21 portátil para essa pasta privada, sem exigir Android Studio ou instalação no Windows.

## 2. Configurar os segredos do GitHub

Converta o arquivo para Base64 e crie em **Settings → Secrets and variables → Actions**:

- `ANDROID_KEYSTORE_BASE64`: conteúdo Base64 do arquivo `.jks`.
- `KEYSTORE_PASSWORD`: senha do arquivo.
- `KEY_ALIAS`: alias usado no comando, por exemplo `smart-life`.
- `KEY_PASSWORD`: senha da chave.

Esses mesmos quatro Secrets são usados pelo APK normal. Assim, todos os APKs serão assinados pela mesma chave e poderão atualizar a versão anterior sem conflito.

## 3. Primeira instalação com a chave permanente

O APK antigo foi assinado por uma chave temporária do GitHub e não poderá ser atualizado. Faça backup dos dados, desinstale o APK antigo uma única vez e instale o primeiro APK gerado após configurar os Secrets. A partir dele, as próximas versões poderão usar **Atualizar** normalmente.

## 4. Gerar o pacote

Abra **Actions → Build Play Store AAB → Run workflow**. Ao terminar, baixe o artefato **Smart-Life v0.8.9 - Play Store**.

Antes de publicar, revise a política de privacidade, os formulários de segurança de dados, os ícones, as capturas de tela e os requisitos atuais de teste do Google Play Console.
