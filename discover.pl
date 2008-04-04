#!/usr/bin/perl

use strict;
use warnings;

use ZipTie::Client;

my $crawl = "false";
if (@ARGV gt 1 and $ARGV[0] eq '-c')
{
    shift(@ARGV);
    $crawl = "true";
}

die("You must specify at least one device!\n") unless (@ARGV);

my $client = ZipTie::Client->new(username => 'admin', password => 'password', host => 'localhost:8080', );

my %address = (key => 'addresses', value => \@ARGV);
my %crawl = (key => 'crawl', value => $crawl);

my %param_map = (entry => [\%address, \%crawl]);

my %job = (description => 'Perl initiated discovery.',
           jobGroup => 'Run now',
           jobName => 'Perl Discovery',
           jobType => 'Discover Devices',
           jobParameters => \%param_map);

my $execution = $client->scheduler()->runNow(jobData => \%job);

print("Scheduled discovery with execution ID: $execution->{id}\n");
