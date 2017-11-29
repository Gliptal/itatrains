@ECHO OFF


GOTO Purge


:Purge

    CALL :RemoveLog || GOTO Error
    CALL :RemoveCache || GOTO Error

    EXIT /B 0


:RemoveLog

    ECHO %TIME:~0,8% [ TASK ] removing .log

    DEL %ERROR_LOG% >NUL 2>NUL

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .log removed
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] removing .log
        GOTO Error
    )

    GOTO :EOF


:RemoveCache

    ECHO %TIME:~0,8% [ TASK ] removing cache

    RD /S /Q .nmlcache >NUL 2>NUL

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] cache removed
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] removing cache
        GOTO Error
    )

    GOTO :EOF


:Error

    EXIT /B 1
