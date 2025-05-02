use v6.d;


use GTK::Simple::HBox;


use Tarot::Deck;
use Tarot::Card;
use Tarot::Spread;

unit class Tarot::Reading;
    also is GTK::Simple::HBox;

has Tarot::Deck $.deck;
has @.cards;
has Tarot::Spread $.spread;

has GTK::Simple::HBox $!box .= new;

method new(*%args) { self.bless: |%args }

submethod TWEAK(:$deck, :$spread) {
    ($!deck, $!spread) = $deck, $spread;

    @!cards := $!spread.order.map({ $!deck.draw-cards($_) }).head;
    dd :@!cards;

    $!box.pack-start($_) for @!cards;
    $!box.border-width = 32;
}


multi method WIDGET() { $!box.WIDGET }
