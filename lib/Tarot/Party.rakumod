
use v6.e.PREVIEW;

use GTK::Simple::App;
use GTK::Simple::VBox;
use GTK::Simple::HBox;
use Tarot::Deck::RWS;
#use Tarot::Card;

unit class Tarot::Party;
    also is GTK::Simple::App;

has $.deck = Tarot::Deck::RWS.new;

submethod TWEAK() {
    self.set-content:
        my $hbox = GTK::Simple::HBox.new:
            GTK::Simple::VBox.new($!deck.draw-card),
            GTK::Simple::VBox.new($!deck.draw-card),
            GTK::Simple::VBox.new($!deck.draw-card);
}