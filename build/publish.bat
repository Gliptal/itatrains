@ECHO OFF


CALL make.bat

IF ERRORLEVEL 1 (
    GOTO End
)

ECHO %TIME:~0,8% [ TASK ] publishing .grf

COPY /Y %GRF_NAME%.grf C:\Users\Utente\Documents\OpenTTD\newgrf\data\%GRF_NAME%.grf >nul 2>nul

IF NOT ERRORLEVEL 1 (
    ECHO %TIME:~0,8% [  OK  ] .grf published
) ELSE (
    ECHO %TIME:~0,8% [ FAIL ] publishing .grf
)

:End
