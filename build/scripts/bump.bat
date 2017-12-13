@ECHO OFF


GOTO Bump


:Bump

    CALL :BumpRelease %1 || GOTO Error
    CALL :BumpVersion
    CALL :CopyChangelog || GOTO Error

    EXIT /B 0


:BumpRelease

    ECHO %TIME:~0,8% [ TASK ] bumping release

    (%SED% %SED_FLAGS% --in-place=.bck s@VERSION.*@"VERSION :%1"@ custom_tags.txt || GOTO Break
    DEL *.bck
    ) >NUL 2>>%ERROR_LOG%

    :Break
    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] release bumped
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] bumping release
        GOTO Error
    )

    GOTO :EOF

:BumpVersion

    ECHO %TIME:~0,8% [ TASK ] bumping version

    %BASH% -c "%AWK% %AWK_FLAGS% '{FS=OFS=\": \"}/version  /{\$NF++\"a\"}1' src/header.nml > tmp && mv tmp src/header.nml"
    (%SED% %SED_FLAGS% --in-place=.bck "/version  /s@$@;@" src\header.nml || GOTO Break
    DEL src\*.bck
    ) >NUL 2>>%ERROR_LOG%

    (FOR /F tokens^=4^ delims^=\^" %%A IN (src/header.nml) DO (
        SETLOCAL ENABLEDELAYEDEXPANSION
        SET ORIG=%%A
        %BASH% -c "printf '%%.2X' $((0x!ORIG!+1))" >tmp || GOTO Break
        SET /p BUMP=<tmp
        DEL tmp
        %SED% %SED_FLAGS% --in-place=.bck "/grfid/s@!ORIG!@!BUMP!@" src\header.nml || GOTO Break
        DEL src\*.bck
    )) >NUL 2>>%ERROR_LOG%

    :Break
    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] version bumped
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] bumping version
        GOTO Error
    )

    GOTO :EOF


:CopyChangelog

    ECHO %TIME:~0,8% [ TASK ] copying changelog

    %SED% %SED_FLAGS%  "s@### @@;s@*@@g;s@---@------------------@" README.md >meta\changelog.txt 2>>%ERROR_LOG%

    IF NOT ERRORLEVEL 1 (
        ECHO %TIME:~0,8% [  OK  ] changelog copied
    ) ELSE (
        ECHO %TIME:~0,8% [ FAIL ] copying changelog
        GOTO Error
    )

    GOTO :EOF


:Error

    EXIT /B 1
