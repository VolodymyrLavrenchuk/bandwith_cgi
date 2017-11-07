#! /opt/csw/bin/perl
use warnings;
use RRDs;

# define location of rrdtool databases
my $rrd = '/mnt/dbs/monitoring';

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
        "305",
        "-w",
        "1120",
        "-aPNG",
        "-v $y_title",
        "-r",
        "--slope-mode"
    ));
}

sub GetGraph
{
    ($host,$name,$var,$multiplier,$color,$legend,$prec,$y_title, $newline) = @_;

    my $last = ($newline) ? "\\n" : "";

    return ("DEF:$var$name=$rrd/$host/$name.rrd:$var:AVERAGE",
        "CDEF:c$var$name=$var$name,$multiplier,*",
        "LINE2:c$var$name#$color:$legend",
        "GPRINT:c$var$name:MIN:Min\\: $prec %s",
        "GPRINT:c$var$name:MAX:Max\\: $prec %s",
        "GPRINT:c$var$name:AVERAGE:Avg\\: $prec %S",
        "GPRINT:c$var$name:LAST:Cur\\: $prec %S$y_title$last"
    );
}

sub CreateGraph
{
    my @graph_array   = GetBaseGraphOptions(@_);
    
    ($period, $title, $file_prefix, $y_title, $opt, @graphs_data) = @_;
    
    my $index;
    my $size = @graphs_data;
    foreach $data(@graphs_data)
    {
        push @graph_array,GetGraph($data->[0],$data->[1],$data->[2],$data->[3],$data->[4],$data->[5],$data->[6],$y_title, ($index++ % 2)||($size == $index));
    }

    #print join("\n ", @graph_array);
    
    RRDs::graph(@graph_array);

	if ($ERROR = RRDs::error) { print "$0: unable to generate $period->{name} $file_prefix graph: $ERROR\n"; }
}