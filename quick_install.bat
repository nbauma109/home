@setlocal enableextensions enabledelayedexpansion
@echo off
cinst -y --force git
cinst -y --force eclipse
cinst -y --force python2
cinst -y --force phantomjs
pushd c:\
rd /s /q casperjs
git clone https://github.com/n1k0/casperjs
popd
if "%PATH%"=="%PATH:casperjs=%" (
    echo Adding casperjs to PATH 
    setx /M PATH "%PATH%;C:\casperjs\bin"
)
endlocal
pause
exit
