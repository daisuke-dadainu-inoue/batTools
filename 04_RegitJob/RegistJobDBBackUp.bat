@ECHO OFF

REM ジョブ名
SET JOBNAME=TestJob

REM バッチファイル格納先
SET BATPATH="C:\test\test.bat"

SCHTASKS /Create /SC DAILY /TN %JOBNAME% /TR %BATPATH% /ST 23:00 /F

pause
