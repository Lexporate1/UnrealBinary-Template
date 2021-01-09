@echo off
set tools_version=2.0.0-preview20201108002
set appcast_path=%UserProfile%\.nuget\packages\netsparkleupdater.tools\%tools_version%\tools\windows\generate_appcast.exe
set appcast_output=%cd%\UnrealBinaryBuilderUpdater
set appcast_binary=%cd%\UnrealBinaryBuilder\bin\Release\netcoreapp3.1\win-x64
set appcast_mainexe=%appcast_binary%\UnrealBinaryBuilder.exe
set appcast_release=https://github.com/ryanjon2040/UE4-Binary-Builder/releases/tag/2.6.1
set appcast_changelog=https://github.com/ryanjon2040/UE4-Binary-Builder/blob/master/README.md
set appcast_default_key_path=%localappdata%\netsparkle

set default_option=0
echo 1 for export-keys
echo 2 for force generate keys
echo 3 for verifying
echo 4 for generating appcast
set /p option=What would you like to do?:

echo %option%
if %option% == 1 (
    %appcast_path% --export true
) else if %option% == 2 (
    %appcast_path% --generate-keys --force true
    %SystemRoot%\explorer.exe appcast_default_key_path
    %appcast_path% --export true
) else if %option% == 3 (
    set /p input_signature=Input your signature
    %appcast_path% --verify "%appcast_mainexe%" --signature %input_signature%
) else if %option% == 4 (
    if exist %appcast_path% (
        echo Generating appcast.xml (Debug)
    	%appcast_path% -a "%appcast_output%" -b "%appcast_binary%" -e exe -o windows -u %appcast_release% -l %appcast_changelog% -n "Unreal Binary Builder" --key-path "%appcast_output%\keys"
    	echo Done.
    ) else (
    	echo generate_appcast.exe was not found.
    )
)


pause