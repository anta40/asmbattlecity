@echo off

echo Pass 1 begin
parse.py tanks.dbg.src.bat 1>tanks.dbg.bat
call tanks.dbg 1>cpl.debug.out

echo Pass 2 begin
parse.py tanks.src.bat cpl.debug.out 1>tanks.bat
rem del cpl.debug.out

call tanks.bat

echo Compiled
