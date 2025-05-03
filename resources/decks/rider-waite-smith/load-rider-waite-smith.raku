#!/usr/bin/env raku
use v6.d;

#use DB::SQLite;
use Tarot::Party::DB;
use Math::Roman;

my $base-path = "{$*CWD}/resources/decks/rider-waite-smith";

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
my @minor-nice = <Ace II III IV V VI VII VIII IX X Page Knight Queen King>;
my %suites = :wands<Wands>, :cups<Cups>, :pentacles<Pentacles>, :swords<Swords>;

my $generator = gather for ^78 -> $c {
    given $c {
        when * ~~ ^22 {
            my $card = @major[$c] ~~ /^ \w+ \s \w+ $/
                ?? @major[$c].split(' ')[1].lc
                !! @major[$c].lc;
            $card = 'hanged' if $card eq 'man';
            take ["major_arcana_$card.jpeg", @major[$c], $c ];
        }
        when * - 22 < 14 {
            my $idx = $c - 22;
            my $path = "minor_arcana_swords_{@minor[$idx].lc}.jpeg";
            my $name = "{@minor-nice[$idx]} of Swords";
            take [$path, $name, $idx+1, 'swords'];
        }
        when * - 36 < 14 {
            my $idx = $c - 36;
            my $path = "minor_arcana_wands_{@minor[$idx].lc}.jpeg";
            my $name = "{@minor-nice[$idx]} of Wands";
            take [$path, $name, $idx+1, 'wands'];
        }
        when * - 50 < 14 {
            my $idx = $c - 50;
            my $path = "minor_arcana_cups_{@minor[$idx].lc}.jpeg";
            my $name = "{@minor-nice[$idx]} of Cups";
            take [$path, $name, $idx+1, 'cups'];
        }
        when * - 64 < 14 {
            my $idx = $c - 64;
            my $path = "minor_arcana_pentacles_{@minor[$idx].lc}.jpeg";
            my $name = "{@minor-nice[$idx]} of Pentacles";
            take [$path, $name, $idx+1, 'pentacles'];
        }
    }
}

my $insert-query = q:to/END-QUERY/;
    INSERT INTO cards (
        deck_id,
        name,
        resource_path,
        position,
        arcana,
        suit
    ) VALUES (?,?,?,?,?,?)
END-QUERY

say "Beginning inserts...";

for $generator[^78] -> $card {
    my $arcana = $++ < 22 ?? 'major' !! 'minor';

    say "====/> Inserting $card[1]...";

    DB.query: $insert-query,
                1, # TODO: Make this less hardcoded
                $card[1],
                $card[0],
                $card[2],
                $arcana,
                $card[3] // Str;
}
