@ECHO OFF
icacls %1 /grant %2:F
@ECHO ON
