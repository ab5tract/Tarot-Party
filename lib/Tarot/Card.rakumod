use v6.d;

use Resource::Wrangler;

use GTK::Simple::Image;
use GTK::Simple::VBox;

use Tarot::Party::DB;

unit class Tarot::Card;
    also does GTK::Simple::Widget;

has Int $.id is built;
has Str $.name is built;
has Bool $.flipped = False;

has GTK::Simple::Image $!image is built;
has GTK::Simple::VBox $!box is built;
multi method WIDGET() { return $!box.WIDGET; }

submethod TWEAK(:$resource-path, :$name, :$id) {
    dd :$name, :$id, :$resource-path;
    my $path = try load-resource-to-path("decks/rider-waite-smith/$resource-path");
    die "TRAGIC ERROR! No card found at '$path'" if not $path.IO.e;

    $!image = GTK::Simple::Image.new: :$path;
    $!image.hide;

    $!box = GTK::Simple::VBox.new: $!image;
    $!box.border-width = 16;

    $!name = $name;
    $!id = $!id;
}

method flip-card {
    if not $!flipped {
        $!flipped = True;
        $!image.show;
    }
}


