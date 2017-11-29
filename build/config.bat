@ECHO OFF


GOTO Config


:Config

    CALL :Tools
    CALL :Build
    CALL :Graphics
    CALL :Game

    EXIT /B 0


:Tools

    SET BASH=bash
    SET NMLC=nmlc
    SET NMLC_FLAGS=--clear-orphaned -c
    SET SED=ssed
    SET SED_FLAGS=
    SET TAR=tar
    SET TAR_FLAGS=
    SET AWK=awk
    SET AWK_FLAGS=

    GOTO :EOF


:Build

    SET ERROR_LOG=build\error.log
    SET NML_FILES=build\files.bat
    SET NML_CONSTANTS=src\constants.nml
    SET GFX_PLACEHOLDERS=build\placeholders.bat

    GOTO :EOF


:Graphics

    SET PLACEHOLDER_IMAGE=placeholder
    SET IMAGE_EXT=png

    GOTO :EOF


:Game

    SET GAME_PATH=C:\Users\Utente\Documents\OpenTTD\newgrf\data
    SET NML_NAME=itatrains.nml
    SET GRF_NAME=itatrains.grf
    SET TAR_NAME=ItalianTrains.tar

    GOTO :EOF
