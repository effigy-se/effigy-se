@echo off
del "tgstation.rsc"
"%~dp0\..\bootstrap\node.bat" --experimental-modules "%~dp0\build.js" %*
