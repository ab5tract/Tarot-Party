use v6.d;

use Tarot::Deck;
use Tarot::Party::DB;

unit class Tarot::Deck::RWS;
    also does Tarot::Deck;

method new(*%args) {
    self.bless(|%args, :name<Rider-Waite-Smith>);
}