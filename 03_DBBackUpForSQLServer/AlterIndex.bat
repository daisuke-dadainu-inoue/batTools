@ECHO OFF

REM �T�[�o�[��
SET SERVERNAME=testserver

REM ���[�U�[ID
SET USERID=test

REM �p�X���[�h
SET PASSWORD=password

REM ���sSQL
SET CALLSQL=%CHDIR%AlterIndex.sql

REM SQL���s
SQLCMD -S %SERVERNAME% -U %USERID% -P %PASSWORD% -i %CALLSQL%
