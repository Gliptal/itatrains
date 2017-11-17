@ECHO OFF

DEL   itatrains.grf
START /WAIT nmlc --grf itatrains.grf itatrains.nml

IF EXIST itatrains.grf (
    COPY /Y itatrains.grf C:\Users\Utente\Documents\OpenTTD\newgrf\data\itatrains.grf >nul
    ECHO  [+]    published
) ELSE (
    ECHO  [-]    generating
)
