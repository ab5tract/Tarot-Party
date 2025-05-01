use v6.d;


use GTK::Simple::HBox;
use GTK::Simple::Button;

use Tarot::Deck;
use Tarot::Card;

unit class Tarot::Reading;

has Tarot::Deck $!deck is built;
has Tarot::Cards @.cards is built;


