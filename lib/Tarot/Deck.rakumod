use v6.d;

use Tarot::Card;
use Tarot::Deck::Misc;
use Tarot::Party::DB;
use Tarot::Party::DB::Decks;

unit role Tarot::Deck;

has $.name is built;
has $.deck-id is built;
has $.strategy is built = Static;

has Tarot::Party::DB::Decks $!db is built;

has @.deck;

submethod TWEAK (:$name){
    $!deck-id = $!db.get-deck-id($!name)
        // fail "Could not find deck '$!name'";
    @!deck = self.reshuffle;
}

multi method draw-card(:$test!, :$index = 0 --> Pair) {
    @!deck or self.reshuffle;
    @!deck[$index]
}

multi method draw-card(--> Tarot::Card) {
    @!deck or self.reshuffle;

    my ($id, $name, $resource-path) = @!deck.shift<rowid name resource_path>;
    Tarot::Card.new: :$id, :$name, :$resource-path;
}

method draw-cards(Int $count where 0 <= *) {
    @!deck or self.reshuffle;

    my @cards;
    @cards.push(self.draw-card) xx 3;
    @cards
}

method reshuffle() {
    @!deck = self!generate-lookup;
    @!deck .= pick(*) unless $!strategy ~~ Static
}

method !generate-lookup {
    dd :$!deck-id;
    |$!db.get-deck($!deck-id)
}