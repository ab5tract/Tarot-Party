use v6.d;

use GTK::Simple::Button;
use GTK::Simple::Entry;
use GTK::Simple::TextView;

use DB::SQLite;

use Tarot::Party::Panel;
use Tarot::Card;

unit class Tarot::Party::Panel::CardDetails;

has @.interpretations of Interpretation;
has Tarot::Card $.card is built;

submethod TWEAK(DB::SQLite :$db, Tarot::Card :$card) {
    self.set-content: self!assemble-panel;
}

method !assemble-panel {
    $!card
}