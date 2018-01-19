@ECHO OFF
CD /D %~dp0

makecert -n "CN=TEST_Client,O=TESTOWNER,C=JP" -a sha256 -b 04/01/2017 -e 03/31/2100 -r -sv test.pvk test.cer
pvk2pfx -pvk test.pvk -pi password -spc test.cer -pfx test.pfx -f

pause
