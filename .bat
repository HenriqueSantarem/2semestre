@echo off
setlocal enabledelayedexpansion

:: Diretório base (pode alterar a letra do disco se quiser)
set "baseDir=C:\GestorArquivos"
set "logFile=%baseDir%\Logs\atividade.log"
set "backupFile=%baseDir%\Backups\backup_completo.bak"
set "resumoFile=%baseDir%\resumo_execucao.txt"

set /a pastasCriadas=0
set /a arquivosCriados=0

:: Função para log
call :log "Início do script" "Sucesso"

:: Criar diretórios
for %%D in ("%baseDir%" "%baseDir%\Documentos" "%baseDir%\Logs" "%baseDir%\Backups") do (
    if not exist %%D (
        mkdir %%D
        call :log "Criar pasta %%D" "Sucesso"
        set /a pastasCriadas+=1
    ) else (
        call :log "Criar pasta %%D" "Já existia"
    )
)

:: Criar arquivos
set "docDir=%baseDir%\Documentos"
(
    echo Relatório de desempenho
) > "%docDir%\relatorio.txt"
call :log "Criar relatorio.txt" "Sucesso"
set /a arquivosCriados+=1

(
    echo nome,idade,email
    echo Ana,30,ana@email.com
) > "%docDir%\dados.csv"
call :log "Criar dados.csv" "Sucesso"
set /a arquivosCriados+=1

(
    echo [config]
    echo modo=automático
) > "%docDir%\config.ini"
call :log "Criar config.ini" "Sucesso"
set /a arquivosCriados+=1

:: Backup
xcopy "%docDir%\*" "%baseDir%\Backups\" /Y >nul
if %errorlevel%==0 (
    call :log "Backup de arquivos" "Sucesso"
) else (
    call :log "Backup de arquivos" "Falha"
)

:: Criar arquivo .bak com data
echo Backup realizado em: %date% %time% > "%backupFile%"
call :log "Criar backup_completo.bak" "Sucesso"

:: Relatório final
(
    echo RELATÓRIO DE EXECUÇÃO
    echo ----------------------
    echo Total de arquivos criados: %arquivosCriados%
    echo Total de pastas criadas: %pastasCriadas%
    echo Data/Hora do backup: %date% %time%
) > "%resumoFile%"
call :log "Criar resumo_execucao.txt" "Sucesso"

goto :EOF

:: Função de log
:log
set "dataHora=%date% %time%"
echo [%dataHora%] - %~1 - %~2 >> "%logFile%"
goto :EOF
