@ECHO OFF
CD /D %~dp0

REM サーバー名
SET SERVERNAME=testserver

REM ユーザーID
SET USERID=test

REM パスワード
SET PASSWORD=password

REM バックアップファイル名
SET BAKUPFILENAME=TEST.bak

REM バックアップ先ディレクトリ
SET OUTDIR=C:\DBBackup\

REM バックアップ日付
SET NOWDATE=%DATE:~-10,4%%DATE:~-5,2%%DATE:~-2,2%\

REM 実行SQL
SET CALLSQL="BACKUP DATABASE TEST TO DISK='%OUTDIR%%NOWDATE%%BAKUPFILENAME%' WITH INIT"

REM バックアップ実行ログ名
SET OUTLOG=%OUTDIR%%NOWDATE%backup.log

REM バックアップフォルダ作成
MKDIR %OUTDIR%%NOWDATE%

REM バックアップ実行
SQLCMD -S %SERVERNAME% -U %USERID% -P %PASSWORD% -Q %CALLSQL% > %OUTLOG%

REM 遅延環境変数
setlocal enabledelayedexpansion

REM 7世代管理
SET SEDAI=7
SET CRTPATH=%CHDIR%

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

REM インデックス再構築
Call AlterIndex.bat

