use v6.d;

use DB::SQLite;

unit module Tarot::Party::DB;

# TODO: Fix to work with resources\

CHECK my $db-handle = DB::SQLite.new: :filename("{ ~$*CWD }/resources/cards.db");

sub term:<DB> is export { $db-handle }

multi sub db-get-id(Int $position where * < 22, Int $deck-id, :$major!) is export {
    state $get-id-query //= q:to/END-QUERY/;
        SELECT  rowid
        FROM    cards
        WHERE   arcana = 'major'
            AND deck_id = ?
            AND position = ?
    END-QUERY

    DB.query($get-id-query, $deck-id, $position).arrays.head.head
        // fail "Could not find record for major arcana (deck_id=$deck-id|position=$position)";
}

multi sub db-get-id(Int $position where * <= 14, Int $deck-id, Str $suit, :$minor!) is export {
    state $get-id-query //= q:to/END-QUERY/;
        SELECT  rowid
        FROM    cards
        WHERE   arcana = 'minor'
            AND suit = ?
            AND deck_id = ?
            AND position = ?
    END-QUERY

    DB.query($get-id-query, $suit, $deck-id, $position).arrays.head.head
        // fail "Could not find record for minor arcana (deck_id=$deck-id|position=$position|suit=$suit)";
}

multi sub db-get-deck-id(Str $deck-name) is export {
    state $get-deck-id-query = q:to/END-QUERY/;
        SELECT rowid from decks where name = ?
    END-QUERY

    DB.query($get-deck-id-query, $deck-name).arrays.head.head
        // fail "Could not find deck named $deck-name";
}

multi sub db-get-deck(Int $deck-id) is export {
    state $get-deck-query //= q:to/END-QUERY/;
        SELECT rowid,* FROM cards WHERE deck_id = ?
    END-QUERY

    DB.query($get-deck-query, $deck-id).hashes
}