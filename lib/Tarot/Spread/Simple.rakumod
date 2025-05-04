use v6.d;

use Tarot::Spread;

unit class Tarot::Spread::Simple;
    also does Tarot::Spread;

method order      { [ 2, 1, 3 ] }
method placements { [ "Internal", "Theme", "External" ] }