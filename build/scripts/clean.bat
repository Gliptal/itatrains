@ECHO OFF


GOTO Clean


:Clean

    CALL :RemoveNml || GOTO Error
    CALL :RemoveGrf || GOTO Error

    EXIT /B 0


:RemoveNml

    ECHO %TIME:~0,8% [ TASK ] removing .nml

    DEL %NML_NAME% >NUL 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .nml removed
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] removing .nml
        GOTO Error
    )

    GOTO :EOF


:RemoveGrf

    ECHO %TIME:~0,8% [ TASK ] removing .grf

    DEL %GRF_NAME% >NUL 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .grf removed
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] removing .grf
        GOTO Error
    )

    GOTO :EOF


:Error

    EXIT /B 1
