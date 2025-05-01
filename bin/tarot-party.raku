#!/usr/bin/env raku
use v6.d;

use Tarot::Party;

unit sub MAIN();

my $party = Tarot::Party.new;
$party.run;
