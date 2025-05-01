use v6.d;

use Tarot::Card;
use Tarot::Deck::Misc;

unit role Tarot::Deck;

has $.name is required;
has DrawStrategy $.strategy is rw = RollAllways;

has @.major is required;
has @.minor is required;
has %.suites is required;

has @.deck;

method !generate-lookup { !!! }

multi method draw-card(:$test!, :$index = 0 --> Pair) { @!deck[$index] }

multi method draw-card(:$strategy = DrawStrategy --> Tarot::Card) {
    self.reshuffle unless +@!deck;

    my Pair $card = do given $strategy // $!strategy {
        when Static      { @!deck[0] }
        when RollOnce    { @!deck.pop}
        when RollAllways { @!deck .= roll(*); @!deck.pop }
    }

    my ($resource-path, $name) = $card.kv;
    Tarot::Card.new: :$name, :$resource-path;
}

method reshuffle() {
    @!deck = self!generate-lookup;
    @!deck .= roll(*) unless $!strategy ~~ Static
}