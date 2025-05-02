use v6.d;

use Tarot::Deck;

unit class Tarot::Deck::RWS;
    also does Tarot::Deck;

my @major =
        'The Fool',
        'The Magician',
        'The High Priestess',
        'The Empress',
        'The Emperor',
        'The Hierophant',
        'The Lovers',
        'The Chariot',
        'Strength',
        'The Hermit',
        'Wheel of Fortune',
        'Justice',
        'The Hanged Man',
        'Death',
        'Temperence',
        'The Devil',
        'The Tower',
        'The Star',
        'The Moon',
        'The Sun',
        'Judgment',
        'The World';

my @minor = <Ace 2 3 4 5 6 7 8 9 10 Page Knight Queen King>;
my %suites = :wands<Wands>, :cups<Cups>, :pentacles<Pentacles>, :swords<Swords>;


method new(*%args) {
    self.bless(|%args, :@major, :@minor, :%suites, :name<Rider-Waite-Smith>);
}

method !generate-lookup() {
    my $generator = gather for ^78 -> $c {
        given $c {
            when * ~~ ^22 {
                my $card = @.major[$c] ~~ /^ \w+ \s \w+ $/
                                ?? @.major[$c].split(' ')[1].lc
                                !! @.major.lc;

                if $card eq 'man' {
                    $card = 'hanged';
                }

                take "major_arcana_$card.jpeg" => @.major[$c];
            }
            when * - 22 < 14 {
                my $idx = $c - 22;
                my $path = "minor_arcana_swords_{@.minor[$idx].lc}.jpeg";
                my $name = "{@.minor[$idx]} of Swords";
                take $path => [$name, $c + 1];
            }
            when * - 36 < 14 {
                my $idx = $c - 36;
                my $path = "minor_arcana_wands_{@.minor[$idx].lc}.jpeg";
                my $name = "{@.minor[$idx]} of Wands";
                take $path => [$name, $c + 1];
            }
            when * - 50 < 14 {
                my $idx = $c - 50;
                my $path = "minor_arcana_cups_{@.minor[$idx].lc}.jpeg";
                my $name = "{@.minor[$idx]} of Cups";
                take $path => [$name, $c + 1];
            }
            when * - 64 < 14 {
                my $idx = $c - 64;
                my $path = "minor_arcana_pentacles_{@.minor[$idx].lc}.jpeg";
                my $name = "{@.minor[$idx]} of Pentacles";
                take $path => [$name, $c + 1];
            }
        }
    }

    |$generator[^78]
}