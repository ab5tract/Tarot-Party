use v6.d;

use DB::SQLite;
use OO::Monitors;
use Resource::Wrangler;

unit monitor Tarot::Party::DB;

has $!filename  is built = load-resource-to-path("cards.db");
has $!db-handle is built = DB::SQLite.new: :$filename;

method DB { $!db-handle }

multi method get-card-id(Int $position where * < 22, Int $deck-id, :$major!) is export {
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

multi method get-card-id(Int $position where * <= 14, Int $deck-id, Str $suit, :$minor!) is export {
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

method sub get-deck-id(Str $deck-name) is export {
    state $get-deck-id-query = q:to/END-QUERY/;
        SELECT rowid from decks where name = ?
    END-QUERY

    DB.query($get-deck-id-query, $deck-name).arrays.head.head
        // fail "Could not find deck named $deck-name";
}

method get-deck-cards(Int $deck-id) is export {
    state $get-deck-query //= q:to/END-QUERY/;
        SELECT rowid,* FROM cards WHERE deck_id = ?
    END-QUERY

    DB.query($get-deck-query, $deck-id).hashes
}