@ECHO OFF


CD ..

ECHO [ TASK ] loading configuration

CALL build\config.bat

ECHO [ TASK ] removing old .nml

DEL %NML_NAME%.nml >nul 2>nul

ECHO [ TASK ] generating new .nml

TYPE nul > %NML_NAME%.nml
(for %%f in (%files%) do (
    TYPE %%f
    ECHO/
)) >> %NML_NAME%.nml

ECHO [ TASK ] removing old .grf

DEL %GRF_NAME%.grf >nul 2>nul

ECHO [ TASK ] generating new .grf

IF "%1"=="/q" (
    nmlc --grf %GRF_NAME%.grf %NML_NAME%.nml >nul 2>nul
) ELSE (
    nmlc --grf %GRF_NAME%.grf %NML_NAME%.nml
)

IF NOT ERRORLEVEL 1 (
    ECHO [  OK  ] .grf generated
) ELSE (
    ECHO [ FAIL ] generating .grf
)
