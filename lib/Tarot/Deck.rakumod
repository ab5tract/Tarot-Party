use v6.d;

use Tarot::Card;
use Tarot::Deck::Enums;
use Tarot::Party::DB::Resources;
use Tarot::Party::DB::Decks;

unit role Tarot::Deck;

has $.name is built;
has $.deck-id is built;
has $.strategy is built = Static;

has Tarot::Party::DB::Decks $!db is built .= new;

has @.deck;

submethod TWEAK (:$name){
    $!deck-id = $!db.get-deck-id($!name)
        // fail "Could not find deck '$!name'";
    @!deck = self.reshuffle;
}

# Mostly useful for tests
multi method draw-card(:$name! --> Tarot::Card) {
    @!deck or self.reshuffle;

    my ($details) = |@!deck.grep: { $_<name> eq $name };
    die "Unable to draw card named '$name'" unless $details;

    Tarot::Card.new:    :id($details<rowid>),
                        :name($name),
                        :path(~$!db.get-resource-path($details<resource_path>))
}

multi method draw-card(--> Tarot::Card) {
    @!deck or self.reshuffle;

    my ($id, $name, $resource) = @!deck.shift<rowid name resource_path>;
    Tarot::Card.new: :$id, :$name, :path(~$!db.get-resource-path($resource));
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

method !generate-lookup { |$!db.get-deck($!deck-id) }