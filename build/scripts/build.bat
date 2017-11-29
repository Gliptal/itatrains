@ECHO OFF


GOTO Build


:Build

    CALL :GenerateNml || GOTO Error
    CALL :ReplacePlaceholders || GOTO Error
    CALL :ReplaceConstants || GOTO Error
    CALL :GenerateGrf || GOTO Error

    EXIT /B 0


:GenerateNml

    ECHO %TIME:~0,8% [ TASK ] generating .nml

    TYPE NUL>%NML_NAME% 2>>%ERROR_LOG%
    (FOR /F "tokens=1" %%A IN (%NML_FILES%) DO (
        FOR %%B IN (%%A) DO (
            TYPE %%B
            ECHO/
        )
    )) >>%NML_NAME% 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .nml generated
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] generating .nml
        GOTO Error
    )

    GOTO :EOF


:ReplacePlaceholders

    ECHO %TIME:~0,8% [ TASK ] replacing placeholders

    (FOR /F "tokens=1" %%A IN (%GFX_PLACEHOLDERS%) DO (
        %SED% %SED_FLAGS% --in-place=.bck s@%%A.%IMAGE_EXT%@%PLACEHOLDER_IMAGE%.%IMAGE_EXT%@ %NML_NAME% || GOTO Break
        DEL *.bck
    )) >NUL 2>>%ERROR_LOG%

    :Break
    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] placeholders replaced
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] replacing placeholders
        GOTO Error
    )

    GOTO :EOF


:ReplaceConstants

    ECHO %TIME:~0,8% [ TASK ] replacing constants

    (FOR /F "tokens=1,3" %%A IN (%NML_CONSTANTS%) DO (
        %SED% %SED_FLAGS% --in-place=.bck s@%%A@%%B@ %NML_NAME% || GOTO Break
        DEL *.bck
    )) >NUL 2>>%ERROR_LOG%

    :Break
    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] constants replaced
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] replacing constants
        GOTO Error
    )

    GOTO :EOF


:GenerateGrf

    ECHO %TIME:~0,8% [ TASK ] generating new .grf

    (IF "%1"=="/v" (
        %NMLC% %NMLC_FLAGS% --grf %GRF_NAME% %NML_NAME%
    ) ELSE (
        %NMLC% %NMLC_FLAGS% --quiet --grf %GRF_NAME% %NML_NAME%
    )) 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] .grf generated
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] generating .grf
        GOTO Error
    )

    GOTO :EOF


:Error

    EXIT /B 1
