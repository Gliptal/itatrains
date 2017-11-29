@ECHO OFF


GOTO Publish


:Publish

    CALL :PackFiles || GOTO Error

    EXIT /B 0


:PackFiles

    ECHO %TIME:~0,8% [ TASK ] creating .tar

    %BASH% -c "%TAR% %TAR_FLAGS% -c --transform 's@^@%TAR_NAME:~0,-4%/@' --transform 's@meta/@@' -f %TAR_NAME% *.grf meta/readme.txt meta/changelog.txt meta/license.txt" >NUL 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .tar created
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] creating .tar
        GOTO Error
    )

    GOTO :EOF


:Error

    EXIT /B 1
