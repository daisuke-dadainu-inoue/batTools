@ECHO OFF
CD /D %~dp0

REM �T�[�o�[��
SET SERVERNAME=testserver

REM ���[�U�[ID
SET USERID=test

REM �p�X���[�h
SET PASSWORD=password

REM �o�b�N�A�b�v�t�@�C����
SET BAKUPFILENAME=TEST.bak

REM �o�b�N�A�b�v��f�B���N�g��
SET OUTDIR=C:\DBBackup\

REM �o�b�N�A�b�v���t
SET NOWDATE=%DATE:~-10,4%%DATE:~-5,2%%DATE:~-2,2%\

REM ���sSQL
SET CALLSQL="BACKUP DATABASE TEST TO DISK='%OUTDIR%%NOWDATE%%BAKUPFILENAME%' WITH INIT"

REM �o�b�N�A�b�v���s���O��
SET OUTLOG=%OUTDIR%%NOWDATE%backup.log

REM �o�b�N�A�b�v�t�H���_�쐬
MKDIR %OUTDIR%%NOWDATE%

REM �o�b�N�A�b�v���s
SQLCMD -S %SERVERNAME% -U %USERID% -P %PASSWORD% -Q %CALLSQL% > %OUTLOG%

REM �x�����ϐ�
setlocal enabledelayedexpansion

REM 7����Ǘ�
SET SEDAI=7
SET CRTPATH=%CHDIR%

REM �t�H���_���擾
FOR /F %%i IN ('DIR /AD /B "!CRTPATH!" ^| FIND /C /V ""') DO (
	SET CNT=%%i
)

REM �o�b�N�A�b�v��̃f�B���N�g���̐����A�ێ����鐢�㐔�𒴂��Ă�����
IF !CNT! GTR !SEDAI! (
	REM �o�b�N�A�b�v��ɂ���A�ł��Â��f�B���N�g����T��
	FOR /F %%a IN ('DIR /AD /O-D /TC /B "!CRTPATH!"') DO (
		SET OLDER=%%a
	)
	ECHO !OLDER!
	REM �ł��Â��f�B���N�g��������������A�폜����
	IF EXIST "!CRTPATH!!OLDER!" (
		RMDIR /S /Q "!CRTPATH!!OLDER!"
	)
)

REM �C���f�b�N�X�č\�z
Call AlterIndex.bat

