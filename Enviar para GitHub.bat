@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Smart Life - Enviar para GitHub

echo ==============================================
echo       SMART LIFE v0.3.2 - GITHUB
echo ==============================================
echo.

where git >nul 2>&1
if errorlevel 1 goto NO_GIT

if not exist ".git" (
  echo Inicializando repositorio local...
  git init
  if errorlevel 1 goto ERROR
)

git branch -M main >nul 2>&1

git config user.name >nul 2>&1
if errorlevel 1 goto ASK_NAME
goto CHECK_EMAIL

:ASK_NAME
echo.
set /p "GIT_NAME=Digite seu nome para os commits: "
if not defined GIT_NAME goto ERROR
git config user.name "%GIT_NAME%"
if errorlevel 1 goto ERROR

:CHECK_EMAIL
git config user.email >nul 2>&1
if errorlevel 1 goto ASK_EMAIL
goto CHECK_REMOTE

:ASK_EMAIL
echo.
set /p "GIT_EMAIL=Digite seu e-mail do GitHub: "
if not defined GIT_EMAIL goto ERROR
git config user.email "%GIT_EMAIL%"
if errorlevel 1 goto ERROR

:CHECK_REMOTE
git remote get-url origin >nul 2>&1
if errorlevel 1 goto ASK_REMOTE
goto PREPARE

:ASK_REMOTE
echo.
echo Cole a URL do repositorio que voce criou no GitHub.
echo Exemplo: https://github.com/usuario/smart-life.git
set /p "REPO_URL=URL do repositorio: "
if not defined REPO_URL goto ERROR
git remote add origin "%REPO_URL%"
if errorlevel 1 goto ERROR

:PREPARE
echo.
echo Preparando arquivos...
git add .
if errorlevel 1 goto ERROR

git diff --cached --quiet
if errorlevel 1 goto COMMIT
echo Nenhuma alteracao nova para commit.
goto SYNC_REMOTE

:COMMIT
echo Criando commit Smart Life v0.3.2...
git commit -m "Smart Life v0.3.2"
if errorlevel 1 goto ERROR

:SYNC_REMOTE
echo.
echo Verificando branch remota...
git ls-remote --exit-code --heads origin main >nul 2>&1
if errorlevel 1 goto PUSH
echo Sincronizando com origin/main antes do envio...
git pull --rebase origin main
if errorlevel 1 goto PULL_ERROR

:PUSH
echo.
echo Enviando para o GitHub...
git push -u origin main
if errorlevel 1 goto ERROR

echo.
echo ==============================================
echo ENVIO CONCLUIDO COM SUCESSO.
echo Abra a aba Actions do GitHub para gerar o APK.
echo ==============================================
pause
exit /b 0

:PULL_ERROR
echo.
echo O repositorio remoto possui alteracoes que nao puderam
echo ser sincronizadas automaticamente.
echo Resolva o conflito indicado acima e execute este BAT novamente.
pause
exit /b 1

:NO_GIT
echo.
echo ERRO: Git nao foi encontrado neste computador.
echo Instale o Git for Windows e tente novamente.
pause
exit /b 1

:ERROR
echo.
echo O envio nao foi concluido.
echo Leia a mensagem acima, corrija o problema e tente novamente.
pause
exit /b 1
