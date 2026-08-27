@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Smart Life - Enviar para GitHub

echo ==============================================
echo       SMART LIFE v0.5.6 - GITHUB
echo ==============================================
echo.

where git >nul 2>&1
if errorlevel 1 goto NO_GIT

git config --global --add safe.directory "%CD%" >nul 2>&1

if not exist ".git" (
  echo Inicializando repositorio local...
  git init
  if errorlevel 1 goto ERROR
  git symbolic-ref HEAD refs/heads/main
)

echo Verificando operacoes anteriores do Git...
git rebase --quit >nul 2>&1
git merge --quit >nul 2>&1

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
if errorlevel 1 goto ADD_REMOTE
git remote set-url origin "https://github.com/LuanClaiver/Smart-Life.git"
if errorlevel 1 goto ERROR
goto PREPARE

:ADD_REMOTE
git remote add origin "https://github.com/LuanClaiver/Smart-Life.git"
if errorlevel 1 goto ERROR

:PREPARE
echo.
echo Preparando os arquivos atuais como versao principal...
git add -A
if errorlevel 1 goto ERROR

git diff --cached --quiet
if errorlevel 1 goto COMMIT
echo Nenhuma alteracao nova para commit.
goto ENSURE_MAIN

:COMMIT
echo Criando commit Smart Life v0.5.6...
git commit -m "Smart Life v0.5.6"
if errorlevel 1 goto ERROR

:ENSURE_MAIN
git checkout -B main >nul 2>&1
if errorlevel 1 goto ERROR

:SYNC_REMOTE
echo.
echo Verificando branch remota...
git ls-remote --exit-code --heads origin main >nul 2>&1
if errorlevel 1 goto PUSH

echo Baixando apenas o historico remoto...
git fetch origin main
if errorlevel 1 goto ERROR

git merge-base --is-ancestor origin/main HEAD >nul 2>&1
if not errorlevel 1 goto PUSH

echo Registrando o historico remoto sem substituir os arquivos atuais...
git merge -s ours --allow-unrelated-histories --no-edit origin/main
if errorlevel 1 goto ERROR

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

:NO_GIT
echo.
echo ERRO: Git nao foi encontrado neste computador.
echo Instale o Git for Windows e tente novamente.
pause
exit /b 1

:ERROR
echo.
echo O envio nao foi concluido.
echo Feche esta janela, extraia novamente o ZIP completo
echo em uma pasta nova e execute este BAT outra vez.
pause
exit /b 1
