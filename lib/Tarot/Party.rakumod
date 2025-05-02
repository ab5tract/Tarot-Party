
use v6.e.PREVIEW;

use GTK::Simple::App;
use GTK::Simple::VBox;
use GTK::Simple::HBox;
use GTK::Simple::Button;
use GTK::Simple::Window;

use Tarot::Deck::RWS;
use Tarot::Reading;
use Tarot::Spread::Simple;

unit class Tarot::Party;
    also is GTK::Simple::App;

has $.deck = Tarot::Deck::RWS.new;
has $.button = GTK::Simple::Button.new(:label("POOD!"));

submethod TWEAK {
    my $reading = Tarot::Reading.new:
                    :deck(Tarot::Deck::RWS.new),
                    :spread(Tarot::Spread::Simple.new);

    my $button-box = GTK::Simple::HBox.new: $!button;
    $button-box.border-width = 64;

    self.set-content(GTK::Simple::VBox.new: $reading, $button-box);
}

sub build-button-box( GTK::Simple::Button $button) {
    GTK::Simple::VBox.new: $button;
}