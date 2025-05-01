use v6.d;

use GTK::Simple::Image;
use GTK::Simple::VBox;

unit class Tarot::Card;
    also does GTK::Simple::Widget;

has Str $.name is built;

has GTK::Simple::Image $!image is built;
has GTK::Simple::VBox $!box is built;
multi method WIDGET() { return $!box.WIDGET; }

submethod TWEAK(:$resource-path, :$name) {
    my $path = $*PROGRAM.parent.parts.tail<basename> eq 'bin'
                    ?? $*PROGRAM.parent.parent.add("resources/decks/rider-waite-smith/$resource-path").absolute
                    !! $*PROGRAM.parent.add("resources/decks/rider-waite-smith/$resource-path").absolute;
    die "TRAGIC ERROR! No card found at '$path'" if not $path.IO.e;

    $!image = GTK::Simple::Image.new: :$path;
    $!box = GTK::Simple::VBox.new($!image);
    $!box.border-width = 16;
}



