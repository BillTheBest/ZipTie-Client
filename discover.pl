#!/usr/bin/perl

use strict;
use warnings;

use ZipTie::Client;

my $crawl = 0;
if (@ARGV gt 1 and $ARGV[0] eq '-c')
{
    shift(@ARGV);
    $crawl = 1;
}

die("You must specify at least one device!\n") unless (@ARGV);

my $client = ZipTie::Client->new(username => 'admin', password => 'password', host => 'localhost:8080', );

my @bad = $client->discovery()->discover(addressSets => \@ARGV, crawlNeighbors => $crawl);

foreach my $invalid (@bad)
{
    print("Skipped invalid device: $invalid\n");
}

exit(@bad);
