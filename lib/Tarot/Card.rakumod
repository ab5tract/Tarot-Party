use v6.d;

use Resource::Wrangler;

use GTK::Simple::Image;
use GTK::Simple::VBox;
use GTK::Simple::EventBox;

use Tarot::Party::DB::Resources;

unit class Tarot::Card;
    also does GTK::Simple::Widget;

has Int $.id is built;
has Str $.name is built;
has Bool $.flipped = False;

has GTK::Simple::Image $!image is built;
has GTK::Simple::VBox $!box is built;
has GTK::Simple::EventBox $!event-box;

multi method WIDGET() { return $!box.WIDGET; }

submethod TWEAK(:$path, :$name, :$id) {
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
