@ECHO OFF
CD /D %~dp0

REM コピー元ディレクトリ
SET ORIGINALNAME=C:\test

REM コピー先ディレクトリ
SET COPYTONAME=\\testserver\test

REM ネットワークドライブ名
SET NETDRIVENAME=W:

REM iniファイル読込
For /F "tokens=1,* delims==" %%a in (AccessUser.ini) do (
	set %%a=%%b
)

REM サーバー接続
NET USE %NETDRIVENAME% %COPYTONAME% %PASSWORD% /USER:%USERID%

REM バックアップ日付
SET NOWDATE=%DATE:~-10,4%%DATE:~-5,2%%DATE:~-2,2%

REM ネットワークドライブ名
SET NETDRIVENAME=W:\TestBackUp\

REM バックアップ実行ログ名
SET OUTLOG=%NETDRIVENAME%%NOWDATE%\backup.log

REM バックアップフォルダ作成
MKDIR %NETDRIVENAME%%NOWDATE%

REM バックアップ実行
XCOPY /E /Q %ORIGINALNAME% %NETDRIVENAME%%NOWDATE%\ > %OUTLOG% 2>&1

REM 遅延環境変数
setlocal enabledelayedexpansion

REM 7世代管理
SET SEDAI=7
SET CRTPATH=%NETDRIVENAME%

REM フォルダ数取得
FOR /F %%i IN ('DIR /AD /B "!CRTPATH!" ^| FIND /C /V ""') DO (
	SET CNT=%%i
)

REM バックアップ先のディレクトリの数が、保持する世代数を超えていたら
IF !CNT! GTR !SEDAI! (
	REM バックアップ先にある、最も古いディレクトリを探す
	FOR /F %%a IN ('DIR /AD /O-D /TC /B "!CRTPATH!"') DO (
		SET OLDER=%%a
	)
	ECHO !OLDER!
	REM 最も古いディレクトリが見つかったら、削除する
	IF EXIST "!CRTPATH!!OLDER!" (
		RMDIR /S /Q "!CRTPATH!!OLDER!"
	)
)

REM ネットワークドライブ名
SET NETDRIVENAME=W:

REM ネットワークドライブ削除
NET USE %NETDRIVENAME% /DELETE

