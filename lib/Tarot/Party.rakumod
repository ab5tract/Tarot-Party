
use v6.e.PREVIEW;

use GTK::Simple::App;
use Tarot::Deck::RWS;
#use Tarot::Card;

unit class Tarot::Party;
    also is GTK::Simple::App;

has $.deck = Tarot::Deck::RWS.new;

submethod TWEAK() {
    dd $!deck.deck;
    self.set-content($!deck.draw-card);
}