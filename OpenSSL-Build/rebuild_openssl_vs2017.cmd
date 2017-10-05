
T:
set OPENSSL_VERSION=1.0.2k
set SEVENZIP="C:\Program Files\7-Zip\7z.exe"
set VS2017="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars32.bat"
set VS2017_AMD64="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars64.bat"


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
ren openssl-%OPENSSL_VERSION% openssl-src-win32-VS2017
%SEVENZIP% x openssl-%OPENSSL_VERSION%.tar
ren openssl-%OPENSSL_VERSION% openssl-src-win64-VS2017

CALL %VS2017%

cd \openssl-src-win32-VS2017
perl Configure VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2017
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\ntdll.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2017
REM nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure debug-VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2017
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\ntdll.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2017
REM nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-release-static-VS2017
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\nt.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2017
REM nmake -f ms\ntdll.mak
nmake -f ms\nt.mak install

perl Configure debug-VC-WIN32 --prefix=T:\openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2017
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\nt.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2017
REM nmake -f ms\ntdll.mak
nmake -f ms\nt.mak install

CALL %VS2017_AMD64%

cd \openssl-src-win64-VS2017
perl Configure VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2017
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure debug-VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2017
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

cd \openssl-src-win64-VS2017
perl Configure VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-release-static-VS2017
call ms\do_win64a.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

perl Configure debug-VC-WIN64A --prefix=T:\openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2017
call ms\do_win64a.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

cd \
python copy_openssl_pys.py

%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2017.7z openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2017.7z openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2017.7z openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2017.7z openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2017.7z openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-release-static-VS2017.7z openssl-%OPENSSL_VERSION%-32bit-release-static-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2017.7z openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2017\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-release-static-VS2017.7z openssl-%OPENSSL_VERSION%-64bit-release-static-VS2017\*

DEL openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-release-static-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2017 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-release-static-VS2017 /Q /F /S

RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-release-static-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2017
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-release-static-VS2017

