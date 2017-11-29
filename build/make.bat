@ECHO OFF


CD ..
CALL :CheckParameters %1 %2 || GOTO Error
GOTO Make


:Make

    CALL :LoadConfig || GOTO Error
    CALL :PrepareLog || GOTO Error

    IF "%1"=="clean" (
         CALL :Clean || GOTO Error
    )
    IF "%1"=="purge" (
        CALL :Purge || GOTO Error
    )
    IF "%1"=="build" (
        CALL :Build || GOTO Error
    )
    IF "%1"=="test" (
        CALL :Test || GOTO Error
    )

    IF "%1"=="publish" (
        CALL :Publish || GOTO Error
    )
    IF "%1"=="bump" (
        CALL :Bump %2 || GOTO Error
    )

    EXIT /B 0


:CheckParameters

    IF "%1"=="" (
        ECHO %TIME:~0,8% [ FAIL ] no option specified
        GOTO Error
    )

    IF NOT "%1"=="clean" IF NOT "%1"=="purge" IF NOT "%1"=="build" IF NOT "%1"=="test" IF NOT "%1"=="publish" IF NOT "%1"=="bump" (
        ECHO %TIME:~0,8% [ FAIL ] no "%1" option
        GOTO Error
    )

    IF "%1"=="bump" IF "%2"=="" (
        ECHO %TIME:~0,8% [ FAIL ] no version specified
        GOTO Error
    )

    GOTO :EOF


:LoadConfig

    ECHO %TIME:~0,8% [ TASK ] loading configuration

    CALL build\config.bat

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] configuration loaded
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] loading configuration
        GOTO Error
    )

    GOTO :EOF


:PrepareLog

    ECHO %TIME:~0,8% [ TASK ] preparing log

    (ECHO/
    ECHO %DATE% %TIME:~0,8% ) >>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] log prepared
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] preparing log
        GOTO Error
    )

    GOTO :EOF


:Clean

    CALL build\scripts\clean.bat || GOTO Error

    GOTO :EOF


:Purge

    CALL :Clean || GOTO Error
    CALL build\scripts\purge.bat || GOTO Error

    GOTO :EOF


:Build

    CALL :Clean || GOTO Error
    CALL build\scripts\build.bat /v || GOTO Error

    GOTO :EOF


:Test

    CALL :Build || GOTO Error
    CALL build\scripts\test.bat || GOTO Error

    GOTO :EOF


:Publish

    CALL :Build || GOTO Error
    CALL build\scripts\publish.bat || GOTO Error

    GOTO :EOF


:Bump

    CALL build\scripts\bump.bat %1 || GOTO Error

    GOTO :EOF


:Error

    EXIT /B 1
