@echo off

set path=%~d0%~p0
set "cpath=insert_libjxl_filepath_here"

:start

"jxl-0.7\cjxl.exe" %1 "%~n1-7.jxl" -d 0.90
echo.
"jxl-0.8.2-apng\cjxl.exe" %1 "%~n1-8.jxl" -d 1
echo.
"jxl-0.9.2\cjxl.exe" %1 "%~n1-9.jxl" -d 0.97
echo.
"jxl-0.10.2\cjxl.exe" %1 "%~n1-10.jxl" -d 1

"%path%djxl.exe" "%~n1-7.jxl" "%~n1-7.png" --quiet --bits_per_sample=16
"%path%djxl.exe" "%~n1-8.jxl" "%~n1-8.png" --quiet --bits_per_sample=16
"%path%djxl.exe" "%~n1-9.jxl" "%~n1-9.png" --quiet --bits_per_sample=16
"%path%djxl.exe" "%~n1-10.jxl" "%~n1-10.png" --quiet --bits_per_sample=16

set "var1=%~n1-7.png"
set "var2=%~n1-8.png"
set "var3=%~n1-9.png"
set "var4=%~n1-10.png"

echo.
echo Conversion has finished. Do you want to continue to comparisons? (y/n)
set /p userinput="Enter your choice: "
if /i "%userinput%"=="n" goto end
if /i "%userinput%"=="y" goto continue

:continue
"%cpath%ssimulacra2.exe" %1 "%var1%" >> comparison.txt
"%cpath%ssimulacra2.exe" %1 "%var2%" >> comparison.txt
"%cpath%ssimulacra2.exe" %1 "%var3%" >> comparison.txt
"%cpath%ssimulacra2.exe" %1 "%var4%" >> comparison.txt
"%cpath%butteraugli_main.exe" %1 "%var1%" >> comparison.txt
"%cpath%butteraugli_main.exe" %1 "%var2%" >> comparison.txt
"%cpath%butteraugli_main.exe" %1 "%var3%" >> comparison.txt
"%cpath%butteraugli_main.exe" %1 "%var4%" >> comparison.txt
"%cpath%dssim.exe" %1 "%var1%" "%var2%" "%var3%" "%var4%" >> comparison.txt

del "%~n1-7.jxl"
del "%~n1-7.png"
del "%~n1-8.jxl"
del "%~n1-8.png"
del "%~n1-9.jxl"
del "%~n1-9.png"
del "%~n1-10.jxl"
del "%~n1-10.png"

:end
shift
if NOT x%1==x goto start