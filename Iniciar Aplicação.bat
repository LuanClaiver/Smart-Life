@echo off
setlocal EnableExtensions
title Smart Life v0.5.1
cd /d "%~dp0"

set "APP_FILE=%~dp0Arquivos principais\www\index.html"

if not exist "%APP_FILE%" (
  echo ERRO: O arquivo principal do Smart Life nao foi encontrado.
  echo Mantenha este BAT na raiz do repositorio, ao lado da pasta Arquivos principais.
  pause
  exit /b 1
)

start "" "%APP_FILE%"
endlocal
exit /b 0
