use v6.d;

unit class Tarot::Interpretation::Card;
    also does Tarot::Interpretation;

has $.card-id;
has $.author;
has @.keywords;
has $.interpretation;

has $.query =
    q:to/END/;
    SELECT
        author,
        keywords,
        interpretation
    FROM
        interpretations
    WHERE
        card_id = $card-id
    END

method load(DB::SQLite $db) {
    ($!author, @!keywords, $!interpretation) = $db.query($!query, :$!card-id)
}