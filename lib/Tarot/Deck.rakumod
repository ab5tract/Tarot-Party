use v6.d;

use Tarot::Card;
use Tarot::Deck::Misc;

unit role Tarot::Deck;

has $.name is required;
has DrawStrategy $.strategy is rw = RollOnce;

has @.major is required;
has @.minor is required;
has %.suites is required;

has @.deck;

method !generate-lookup { !!! }

multi method draw-card(:$test!, :$index = 0 --> Pair) {
    @!deck or self.reshuffle;
    @!deck[$index]
}

multi method draw-card(--> Tarot::Card) {
    @!deck or self.reshuffle;

    my ($resource-path, $name) = @!deck.shift.kv;
    Tarot::Card.new: :$name, :$resource-path;
}

method reshuffle() {
    @!deck = self!generate-lookup;
    @!deck .= pick(*) unless $!strategy ~~ Static
}