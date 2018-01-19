@ECHO OFF
CD /D %~dp0

REM �R�s�[���f�B���N�g��
SET ORIGINALNAME=C:\test

REM �R�s�[��f�B���N�g��
SET COPYTONAME=\\testserver\test

REM �l�b�g���[�N�h���C�u��
SET NETDRIVENAME=W:

REM ini�t�@�C���Ǎ�
For /F "tokens=1,* delims==" %%a in (AccessUser.ini) do (
	set %%a=%%b
)

REM �T�[�o�[�ڑ�
NET USE %NETDRIVENAME% %COPYTONAME% %PASSWORD% /USER:%USERID%

REM �o�b�N�A�b�v���t
SET NOWDATE=%DATE:~-10,4%%DATE:~-5,2%%DATE:~-2,2%

REM �l�b�g���[�N�h���C�u��
SET NETDRIVENAME=W:\TestBackUp\

REM �o�b�N�A�b�v���s���O��
SET OUTLOG=%NETDRIVENAME%%NOWDATE%\backup.log

REM �o�b�N�A�b�v�t�H���_�쐬
MKDIR %NETDRIVENAME%%NOWDATE%

REM �o�b�N�A�b�v���s
XCOPY /E /Q %ORIGINALNAME% %NETDRIVENAME%%NOWDATE%\ > %OUTLOG% 2>&1

REM �x�����ϐ�
setlocal enabledelayedexpansion

REM 7����Ǘ�
SET SEDAI=7
SET CRTPATH=%NETDRIVENAME%

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

REM �l�b�g���[�N�h���C�u��
SET NETDRIVENAME=W:

REM �l�b�g���[�N�h���C�u�폜
NET USE %NETDRIVENAME% /DELETE

