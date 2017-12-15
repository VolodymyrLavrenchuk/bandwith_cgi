@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set FIELDS=gputemp:gpuload:gpupower:memload:fanspeed
set HOSTNAME=%COMPUTERNAME%

call :tolower HOSTNAME

SET /a idx=0
for /f "tokens=1-5 delims=, " %%a in ('"C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe" --query-gpu^=temperature.gpu^,utilization.gpu^,power.draw^,utilization.memory^,fan.speed --format^=csv^,noheader^,nounits') do (
  set VALUES=%%a:%%b:%%c:%%d:%%e
  for /d %%G in (!VALUES!) do (

    set DBPATH=dbs\gpu!idx!.rrd
    set XMLPATH=\\scorpion-oi\dbs\monitoring\%HOSTNAME%\xmls\gpu!idx!.xml

    if not exist !DBPATH! (
        echo %DATE% %TIME% creating databse: "!DBPATH!"
        rrdtool create !DBPATH! --step 300^
         DS:gputemp:GAUGE:600:0:100^
         DS:gpuload:GAUGE:600:0:100^
         DS:gpupower:GAUGE:600:0:500^
         DS:memload:GAUGE:600:0:100^
         DS:fanspeed:GAUGE:600:0:100^
         RRA:AVERAGE:0.5:1:576^
         RRA:AVERAGE:0.5:6:672^
         RRA:AVERAGE:0.5:24:732^
         RRA:AVERAGE:0.5:144:1460
    )

    echo %DATE% %TIME% updating database: "!DBPATH!" fields: "%FIELDS%" with values: "%%G"
    rrdtool update !DBPATH! -t %FIELDS% N:%%G
    echo %DATE% %TIME% export database: "!DBPATH!" to: "!XMLPATH!"
    rrdtool dump !DBPATH! > !XMLPATH!
  )
  set /a idx+=1

)
goto :EOF

:tolower
for %%L IN (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO SET %1=!%1:%%L=%%L!
goto :EOF
