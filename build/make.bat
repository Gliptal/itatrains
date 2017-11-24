@ECHO OFF


CD ..

ECHO %TIME:~0,8% [ TASK ] loading configuration

CALL build\config.bat

ECHO %TIME:~0,8% [ TASK ] removing old .nml

DEL %NML_NAME%.nml >nul 2>nul

ECHO %TIME:~0,8% [ TASK ] generating new .nml

TYPE nul > %NML_NAME%.nml
(FOR %%f IN (%FILES%) DO (
    TYPE %%f
    ECHO/
)) >> %NML_NAME%.nml

ECHO %TIME:~0,8% [ TASK ] replacing constants

FOR /F "tokens=1,3" %%A IN (src\%CONSTANTS%.nml) DO (
    ssed --in-place=.bck s@%%A@%%B@ itatrains.nml

    IF ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [ FAIL ] replacing constants
        GOTO End
    )

    DEL %NML_NAME%.nml.bck >nul 2>nul
)

ECHO %TIME:~0,8% [  OK  ] constants replaced

ECHO %TIME:~0,8% [ TASK ] removing old .grf

DEL %GRF_NAME%.grf >nul 2>nul

ECHO %TIME:~0,8% [ TASK ] generating new .grf

IF "%1"=="/v" (
    %NML_COMPILER% %NML_COMPILER_FLAGS% --grf %GRF_NAME%.grf %NML_NAME%.nml
) ELSE (
    %NML_COMPILER% %NML_COMPILER_FLAGS% --quiet --grf %GRF_NAME%.grf %NML_NAME%.nml
)

IF NOT ERRORLEVEL 1 (
    ECHO %TIME:~0,8% [  OK  ] .grf generated
) ELSE (
    ECHO %TIME:~0,8% [ FAIL ] generating .grf
)

:End
