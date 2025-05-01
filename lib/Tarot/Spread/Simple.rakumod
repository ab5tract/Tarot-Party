use v6.d;

use Tarot::Spread;

unit class Tarot::Spread::Simple;
    also does Tarot::Spread;

submethod TWEAK {
    @!order = [ 3 ];
    @!placements = [ "Internal", "Theme", "External" ]
}