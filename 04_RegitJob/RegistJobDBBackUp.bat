@ECHO OFF

REM �W���u��
SET JOBNAME=TestJob

REM �o�b�`�t�@�C���i�[��
SET BATPATH="C:\test\test.bat"

SCHTASKS /Create /SC DAILY /TN %JOBNAME% /TR %BATPATH% /ST 23:00 /F

pause
