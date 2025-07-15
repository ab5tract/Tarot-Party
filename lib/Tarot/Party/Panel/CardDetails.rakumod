use v6.*;

use GTK::Simple::Button;
use GTK::Simple::Entry;
use GTK::Simple::TextView;

use DB::SQLite;

use Tarot::Party::Panel;
use Tarot::Interpretation;
use Tarot::Card;

unit class Tarot::Party::Panel::CardDetails;
    also does Tarot::Party::Panel;

has Tarot::Card $.card is built;
has @.interpretations of Tarot::Interpretation;

submethod TWEAK(DB::SQLite :$db, Tarot::Card :$card) {
    self.set-content: self!assemble-panel;
}

method !assemble-panel {
    $!card
}