@echo off
set DBPATH=dbs\gpu.rrd
set XMLPATH=\\scorpion-oi\dbs\monitoring\scorpion-ws\xmls\gpu.xml
set FIELDS=gputemp:gpuload:gpupower:memload:fanspeed

SETLOCAL ENABLEDELAYEDEXPANSION  
for /f "tokens=1-5 delims=, " %%a in ('"C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe" --query-gpu^=temperature.gpu^,utilization.gpu^,power.draw^,utilization.memory^,fan.speed --format^=csv^,noheader^,nounits') do (
  set VALUES=%%a:%%b:%%c:%%d:%%e
  if not exist %DBPATH% (
      echo %DATE% %TIME% creating databse: "%DBPATH%"
      rrdtool create %DBPATH% --step 300^
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
  
  echo %DATE% %TIME% updating database: "%DBPATH%" fields: "%FIELDS%" with values: "!VALUES!"
  rrdtool update %DBPATH% -t %FIELDS% N:!VALUES!
  echo %DATE% %TIME% export database: "%DBPATH%" to: "%XMLPATH%"
  rrdtool dump %DBPATH% > %XMLPATH%
)
