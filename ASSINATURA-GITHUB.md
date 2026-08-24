# Criar a assinatura Android diretamente no GitHub

Este procedimento é realizado uma única vez. A chave criada será usada em todos os APKs e AABs futuros do Smart Life.

## 1. Criar a senha temporária

No repositório do Smart Life, abra **Settings → Secrets and variables → Actions → New repository secret**.

Crie:

- Nome: `SIGNING_PASSWORD`
- Valor: uma senha forte com pelo menos 12 caracteres.

Guarde essa senha fora do GitHub. Não use a senha da sua conta.

## 2. Gerar a assinatura

1. Abra **Actions**.
2. Escolha **Criar assinatura Android (uma vez)**.
3. Clique em **Run workflow**.
4. Digite exatamente `CRIAR ASSINATURA`.
5. Clique no botão verde **Run workflow**.
6. Aguarde a execução ficar verde.

## 3. Baixar e guardar a chave

1. Abra a execução concluída.
2. Na seção **Artifacts**, baixe **Smart-Life-Assinatura-Permanente**.
3. Extraia o ZIP.
4. Guarde `smart-life-upload.jks` em pelo menos dois locais seguros.

Essa chave não poderá ser recriada. Se ela for perdida, novos APKs não conseguirão atualizar os anteriores.

## 4. Criar os Secrets permanentes

Volte a **Settings → Secrets and variables → Actions** e crie:

- `ANDROID_KEYSTORE_BASE64`: todo o conteúdo de `ANDROID_KEYSTORE_BASE64.txt`.
- `KEYSTORE_PASSWORD`: a mesma senha forte usada em `SIGNING_PASSWORD`.
- `KEY_PASSWORD`: a mesma senha forte usada em `SIGNING_PASSWORD`.
- `KEY_ALIAS`: `smart-life`.

Depois de conferir os quatro Secrets, exclua o Secret temporário `SIGNING_PASSWORD`.

## 5. Apagar o artefato temporário

Volte à execução **Criar assinatura Android (uma vez)** e exclua a execução. O artefato também expira automaticamente após um dia.

## 6. Gerar o APK definitivo

Abra **Actions → Build Android APK → Run workflow**. O download será disponibilizado como `Smart-Life-APK-v0.5.1`.

O APK antigo, assinado pela chave temporária anterior, precisa ser desinstalado uma única vez. Faça backup, instale este primeiro APK permanente e importe os dados. As versões seguintes poderão usar **Atualizar** normalmente.
