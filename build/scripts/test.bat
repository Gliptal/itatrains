@ECHO OFF


GOTO Test


:Test

    CALL :CopyGrf || GOTO Error

    EXIT /B 0


:CopyGrf

    ECHO %TIME:~0,8% [ TASK ] copying .grf

    COPY /Y %GRF_NAME% %GAME_PATH%\%GRF_NAME% >NUL 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .grf copied
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] copying .grf
        GOTO Error
    )

    GOTO :EOF


:Error

    EXIT /B 1
