
use v6.e.PREVIEW;

use GTK::Simple::App;
use GTK::Simple::VBox;
use GTK::Simple::HBox;
use Tarot::Deck::RWS;
#use Tarot::Card;

use Tarot::Reading;
use Tarot::Spread::Simple;

unit class Tarot::Party;
    also is GTK::Simple::App;

has $.deck = Tarot::Deck::RWS.new;

submethod TWEAK() {
    my $reading = Tarot::Reading.new(:deck(Tarot::Deck::RWS.new), :spread(Tarot::Spread::Simple.new));

    self.set-content: $reading;

#    self.set-content:
#        my $hbox = GTK::Simple::HBox.new:
#            GTK::Simple::VBox.new($!deck.draw-card),
#            GTK::Simple::VBox.new($!deck.draw-card),
#            GTK::Simple::VBox.new($!deck.draw-card);
}