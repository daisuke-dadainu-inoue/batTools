@ECHO OFF

REM サーバー名
SET SERVERNAME=testserver

REM ユーザーID
SET USERID=test

REM パスワード
SET PASSWORD=password

REM 実行SQL
SET CALLSQL=%CHDIR%AlterIndex.sql

REM SQL実行
SQLCMD -S %SERVERNAME% -U %USERID% -P %PASSWORD% -i %CALLSQL%
