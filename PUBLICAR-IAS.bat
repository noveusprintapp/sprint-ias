@echo off
chcp 65001 >nul
REM Publica os modelos das IAs do painel no GitHub PUBLICO (noveusprintapp/sprint-ias, versao v1).
REM So modelos abertos: nada de chave, loja ou cliente aqui.
cd /d "%~dp0"
set "LOG=%~dp0publicar-ias.log"
echo IAs %DATE% %TIME% > "%LOG%"
where git >nul 2>&1
if errorlevel 1 goto semgit
where gh >nul 2>&1
if errorlevel 1 goto semgit
gh auth status >nul 2>&1
if errorlevel 1 gh auth login --web --git-protocol https --hostname github.com
gh auth setup-git >> "%LOG%" 2>&1
for /f %%u in ('gh api user --jq .login') do set "GHUSER=%%u"
echo Conta do GitHub: %GHUSER%
if not exist ".git" git init -b main >> "%LOG%" 2>&1
git config user.name "%GHUSER%"
git config user.email "%GHUSER%@users.noreply.github.com"
git add -A >> "%LOG%" 2>&1
git diff --cached --quiet
if errorlevel 1 git commit -q -m "Modelos das IAs" >> "%LOG%" 2>&1
git remote get-url origin >nul 2>&1
if errorlevel 1 gh repo create sprint-ias --public --source . --remote origin >> "%LOG%" 2>&1
echo Enviando, uns 185 MB. Pode demorar alguns minutos...
git push -u origin main >> "%LOG%" 2>&1
if errorlevel 1 goto erro
git tag -f v1 >> "%LOG%" 2>&1
git push -f origin v1 >> "%LOG%" 2>&1
if errorlevel 1 goto erro
echo.
echo PRONTO. As IAs estao em https://github.com/%GHUSER%/sprint-ias
if /i not "%GHUSER%"=="noveusprintapp" echo ATENCAO: sua conta e %GHUSER%, mas o painel procura em noveusprintapp. Avise o Claude.
goto fim
:semgit
echo Rode antes o SALVAR-NO-GITHUB.bat da pasta Documentos: ele instala o Git e o GitHub CLI.
goto fim
:erro
echo ERRO ao enviar. Veja o arquivo publicar-ias.log nesta pasta.
:fim
echo.
pause
