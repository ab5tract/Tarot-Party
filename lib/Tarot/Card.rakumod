use v6.d;

use GTK::Simple::Image;

unit class Tarot::Card;
    also does GTK::Simple::Widget;

has Str $.name is built;

# My idea here is to sub-class widget rather than image directly,
# just in case we end up wanting to do a bit of wrapping.
# But for now, just return the WIDGET of our image

has GTK::Simple::Image $.image is built;
multi method WIDGET() { return $!image.WIDGET; }


submethod TWEAK(:$resource-path, :$name) {
    ## One day I will comprehend resources...
##    dd %?RESOURCES{$resource-path}[0].absolute;
#
#    $!name = $name;
#    $!image = GTK::Simple::Image.new(:path(~%?RESOURCES{$resource-path}));
    my $path = $*PROGRAM.parent.parts.last eq 'bin'
                    ?? $*PROGRAM.parent.parent.add("resources/decks/raider-waite-smith/$resource-path").absolute
                    !! $*PROGRAM.parent.add("resources/decks/raider-waite-smith/$resource-path").absolute;
    $!image = GTK::Simple::Image.new: :$path;
}



