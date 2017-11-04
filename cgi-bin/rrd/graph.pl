#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

# get the server name (or you could hard code some description here)
#my $svrname = $ENV{'SERVER_NAME'};

# get url parameters
my @qstring = split(/&/, $ENV{'QUERY_STRING'});
my %qparams;
foreach my $i (@qstring)
{
	($parname, $value) = split(/=/, $i);
   $qparams{ $parname } = $value;
}

require "$cur_dir/graph/$qparams{'host'}/$qparams{'trend'}.pl";

my $name=$qparams{'trend'};

print "Content-type: text/html;\n\n";
print <<END
<html>
<head>
  <TITLE>$name</TITLE>
  <META HTTP-EQUIV="Refresh" CONTENT="300">
  <META HTTP-EQUIV="Cache-Control" content="no-cache">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <style>
    .header { font-size: 16pt; font-weight: 900; }
  </style>
  <link rel="stylesheet" type="text/css" href="/css/mainmenu.css" />
  <script type="text/javascript" src="/scripts/common.js"></script>
  <script type="text/javascript" src="/scripts/mainmenu.js"></script>  
</head>
<body bgcolor="#83A4BA" text="#000000" link="#0000FF" vlink="#000080" alink="#FF0000" topMargin='5'>
<div id="menu"></div>
<center>
<span class='header'>$name</span>
<br>
END
;

print <<END
<img src='/images/$name-day.png'>
<br>
<img src='/images/$name-week.png'>
<br>
<img src='/images/$name-month.png'>
<br>
<img src='/images/$name-year.png'>
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
