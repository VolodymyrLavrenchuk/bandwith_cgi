#! /opt/csw/bin/perl

my ($name, $descr);

# get the server name (or you could hard code some description here)
#my $svrname = $ENV{'SERVER_NAME'};

# get url parameters
my @values = split(/&/, $ENV{'QUERY_STRING'});
foreach my $i (@values) 
{
	($varname, $mydata) = split(/=/, $i);
	if ($varname eq 'trend')
	{
		$name = $mydata;
	}
}

print "Content-type: text/html;\n\n";
print <<END
<html>
<head>
  <TITLE>$name</TITLE>
  <META HTTP-EQUIV="Refresh" CONTENT="300">
  <META HTTP-EQUIV="Cache-Control" content="no-cache">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <style>
    body { font-family: Verdana,Tahoma,Arial,Helvetica; font-size:9pt}
    .header { font-size: 16pt; font-weight: 900; }
  </style>
</head>
<body bgcolor="#83A4BA" text="#000000" link="#0000FF" vlink="#000080" alink="#FF0000" topMargin='5'>
<center>
<span class='header'>$name</span>
<br><br>
END
;

print <<END
Daily Graph (5 minute averages)
<br>
<img src='/rrd/$name-day.png'>
<br>
Weekly Graph (30 minute averages)
<br>
<img src='/rrd/$name-week.png'>
<br>
Monthly Graph (2 hour averages)
<br>
<img src='/rrd/$name-month.png'>
<br>
Yearly Graph (12 hour averages)
<br>
<img src='/rrd/$name-year.png'>
END
;

print <<END
<br><br>
<a href='http://tobi.oetiker.ch/~oetiker/webtools/rrdtool/'>
<img src='http://tobi.oetiker.ch/~oetiker/webtools/rrdtool/.pics/rrdtool.gif' border='0'></a>
</center>
</body>
</html>
END
;
