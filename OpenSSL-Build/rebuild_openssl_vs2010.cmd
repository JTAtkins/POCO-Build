
T:
set OPENSSL_VERSION=1.0.2k
set SEVENZIP="C:\Program Files\7-Zip\7z.exe"
set VS2010="C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\vcvars32.bat"
set VS2010_AMD64="C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\amd64\vcvars64.bat"

REM Remove openssl source directories
IF NOT EXIST "T:\openssl-src-win32" GOTO NO_WIN32_SOURCE
DEL "T:\openssl-src-win32" /Q /F /S
RMDIR /S /Q "T:\openssl-src-win32"
:NO_WIN32_SOURCE

IF NOT EXIST "T:\openssl-src-win64" GOTO NO_WIN64_SOURCE
DEL "T:\openssl-src-win64" /Q /F /S
RMDIR /S /Q "T:\openssl-src-win64"
:NO_WIN64_SOURCE

IF NOT EXIST "T:\openssl-%OPENSSL_VERSION%" GOTO NO_OPENSSL_SOURCE
DEL "T:\openssl-%OPENSSL_VERSION%" /Q /F /S
RMDIR /S /Q "T:\openssl-%OPENSSL_VERSION%"
:NO_OPENSSL_SOURCE

del openssl-%OPENSSL_VERSION%.tar
%SEVENZIP% e openssl-%OPENSSL_VERSION%.tar.gz
%SEVENZIP% x openssl-%OPENSSL_VERSION%.tar
ren openssl-%OPENSSL_VERSION% openssl-src-win32-vs2010
%SEVENZIP% x openssl-%OPENSSL_VERSION%.tar
ren openssl-%OPENSSL_VERSION% openssl-src-win64-vs2010

CALL %VS2010%

cd \openssl-src-win32-vs2010
perl Configure VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-release-DLL-vs2010
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure debug-VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-debug-DLL-vs2010
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-release-static-vs2010
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

perl Configure debug-VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-debug-static-vs2010
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

CALL %VS2010_AMD64%

cd \openssl-src-win64-vs2010
perl Configure VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-release-DLL-vs2010
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure debug-VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-debug-DLL-vs2010
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

cd \openssl-src-win64-vs2010
perl Configure VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-release-static-vs2010
call ms\do_win64a.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

perl Configure debug-VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-debug-static-vs2010
call ms\do_win64a.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

cd \
python copy_openssl_pys.py

%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-debug-DLL-vs2010.7z openssl-%OPENSSL_VERSION%-32bit-debug-DLL-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-release-DLL-vs2010.7z openssl-%OPENSSL_VERSION%-32bit-release-DLL-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-debug-DLL-vs2010.7z openssl-%OPENSSL_VERSION%-64bit-debug-DLL-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-release-DLL-vs2010.7z openssl-%OPENSSL_VERSION%-64bit-release-DLL-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-debug-static-vs2010.7z openssl-%OPENSSL_VERSION%-32bit-debug-static-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-release-static-vs2010.7z openssl-%OPENSSL_VERSION%-32bit-release-static-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-debug-static-vs2010.7z openssl-%OPENSSL_VERSION%-64bit-debug-static-vs2010\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-release-static-vs2010.7z openssl-%OPENSSL_VERSION%-64bit-release-static-vs2010\*

DEL openssl-%OPENSSL_VERSION%-32bit-debug-DLL-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-release-DLL-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-debug-DLL-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-release-DLL-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-debug-static-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-release-static-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-debug-static-vs2010 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-release-static-vs2010 /Q /F /S

RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-debug-DLL-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-release-DLL-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-debug-DLL-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-release-DLL-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-debug-static-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-release-static-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-debug-static-vs2010
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-release-static-vs2010

