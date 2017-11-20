@ECHO OFF


CALL make.bat /q

IF ERRORLEVEL 1 (
    ECHO [ TASK ] finding error

    CALL build\make.bat /s

    GOTO End
)

ECHO [ TASK ] publishing .grf

COPY /Y %GRF_NAME%.grf C:\Users\Utente\Documents\OpenTTD\newgrf\data\%GRF_NAME%.grf >nul 2>nul

IF NOT ERRORLEVEL 1 (
    ECHO [  OK  ] .grf published
) ELSE (
    ECHO [ FAIL ] publishing .grf
)

:End
