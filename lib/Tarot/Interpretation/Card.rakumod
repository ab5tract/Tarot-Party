use v6.d;

use Tarot::Interpretation;
use DB::SQLite;

unit class Tarot::Interpretation::Card;
    also does Tarot::Interpretation;

has Int $.card-id;
has Str $.author;
has @.keywords;
has Str $.interpretation;

my $query-template =
    q:to/END/;
    SELECT
        author,
        keywords,
        interpretation
    FROM
        card_interpretations
    WHERE
        card_id = ?
    END


# This is a class method
method new(DB::SQLite :$db, Int :$card-id) {
    my ($author, $keywords, $interpretation) = DB.query($query-template, $card-id).array;
    self.bless: :$card-id
                :$author,
                :$interpretation,
                :keywords($keywords.split(","));
}