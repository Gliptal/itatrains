@ECHO OFF


CD ..

ECHO [ TASK ] loading configuration

CALL build\config.bat

ECHO [ TASK ] removing old .nml

DEL %NML_NAME%.nml >nul 2>nul

ECHO [ TASK ] generating new .nml

TYPE nul              >  %NML_NAME%.nml
TYPE src\header.nml   >> %NML_NAME%.nml
ECHO/                 >> %NML_NAME%.nml
TYPE src\generic.nml  >> %NML_NAME%.nml
ECHO/                 >> %NML_NAME%.nml
TYPE src\vehicles.nml >> %NML_NAME%.nml
ECHO/                 >> %NML_NAME%.nml
TYPE src\trains.nml   >> %NML_NAME%.nml

ECHO [ TASK ] removing old .grf

DEL %GRF_NAME%.grf >nul 2>nul

ECHO [ TASK ] generating new .grf

IF "%1"=="/v" (
    nmlc --grf %GRF_NAME%.grf %NML_NAME%.nml
) ELSE (
    nmlc --grf %GRF_NAME%.grf %NML_NAME%.nml >nul 2>nul
)

IF NOT ERRORLEVEL 1 (
    ECHO [  OK  ] .grf generated
) ELSE (
    ECHO [ FAIL ] generating .grf
)
