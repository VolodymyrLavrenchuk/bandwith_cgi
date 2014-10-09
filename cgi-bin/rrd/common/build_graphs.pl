#! /opt/csw/bin/perl
use warnings;
use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# define location of images
my $img = '/www/images';

sub BuildGraphs
{
    @periods = (
    {name => "day", label=> "daily, 5 minute averages"},
    {name => "week", label=> "weekly, 30 minute averages"},
    {name => "month", label=> "monthly, 2 hour averages"},
    {name => "year", label=> "yearly, 12 hour averages"}
    );
    foreach $period(@periods)
    {
        CreateGraph($period, @_);
    };
}

sub GetBaseGraphOptions
{
    ($period, $title, $file_prefix, $y_title) = @_;
    my (@options) = @{$_[4]};
    return (@options,("$img/$file_prefix-$period->{name}.png",
        "-s -1$period->{name}",
        "-t $title ($period->{label})",
        "--lazy",
        "-h",
        "250",
        "-w",
        "1100",
        "-aPNG",
        "-v $y_title",
        "-r",
        "--slope-mode"
    ));
}

sub GetGraph
{
    ($name,$var,$color,$legend,$prec,$y_title) = @_;
    
    return ("DEF:$var$name=$rrd/$name.rrd:$var:AVERAGE",
        "LINE2:$var$name#$color:$legend",
        "GPRINT:$var$name:MIN: Min\\: $prec %s",
        "GPRINT:$var$name:MAX: Max\\: $prec %s",
        "GPRINT:$var$name:AVERAGE: Avg\\: $prec %S",
        "GPRINT:$var$name:LAST: Current\\: $prec %S$y_title\\n"
    );
}

sub CreateGraph
{
    my @graph_array   = GetBaseGraphOptions(@_);
    
    ($period, $title, $file_prefix, $y_title, $opt, @graphs_data) = @_;
    
    foreach $data(@graphs_data)
    {
        push @graph_array,GetGraph($data->[0],$data->[1],$data->[2],$data->[3],$data->[4],$y_title);
    }
    
    RRDs::graph(@graph_array);

	if ($ERROR = RRDs::error) { print "$0: unable to generate $period->{name} $file_prefix graph: $ERROR\n"; }
}