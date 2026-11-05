@echo off
rem Clang + ThinLTO + x86-64-v3 + PGO build of eglantine.exe and eden-cli.exe, into build-clang\bin.
rem See FORK.md for what TOOLS must contain.
if not defined TOOLS (
    echo Set TOOLS first, for example: set TOOLS=J:\dev\tools
    exit /b 1
)
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" >nul
set PATH=%TOOLS%\LLVM\bin;%TOOLS%\cmake\bin;%TOOLS%\ninja;%TOOLS%\glslang\bin;%PATH%
cd /d "%~dp0.."
if not exist build-clang\build.ninja (
    cmake -C tuned\pgo-use-fork.cmake -S . -B build-clang -G Ninja
    if errorlevel 1 exit /b 1
)
ninja -C build-clang -j4 eden-cli.exe eglantine.exe
