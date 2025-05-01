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
                take "minor_arcana_swords_{@.minor[$c - 22].lc}.jpeg" => "{@.minor[$c - 22]} of Swords";
            }
            when * - 36 < 14 {
                take "minor_arcana_wands_{@.minor[$c - 36].lc}.jpeg" => "{@.minor[$c -36]} of Wands";
            }
            when * - 50 < 14 {
                take "minor_arcana_cups_{@.minor[$c - 50].lc}.jpeg" => "{@.minor[$c - 50]} of Cups";
            }
            when * - 64 < 14 {
                take "minor_arcana_pentacles_{@.minor[$c - 64].lc}.jpeg" => "{@.minor[$c - 64]} of Pentacles";
            }
        }
    }

    |$generator[^78]
}