use v6.*;

use Resource::Wrangler;
use OO::Monitors;
use DB::SQLite;

use Tarot::Party::DB;
use Tarot::Party::DB::Base;

unit monitor Tarot::Party::DB::Cards;
    also does Tarot::Party::DB::Base;

method !load-db(--> DB::SQLite) {
    DB::SQLite.new: filename => ~ Wrangler.load-resource-to-path("cards.db")
}

multi method get-card-id(Int $position where * < 22, Int $deck-id, :$major!) {
    state $get-id-query //= q:to/END-QUERY/;
        SELECT  rowid
        FROM    cards
        WHERE   arcana = 'major'
            AND deck_id = ?
            AND position = ?
    END-QUERY

    self.DB.query($get-id-query, $deck-id, $position).arrays.head.head
        // fail "Could not find record for major arcana (deck_id=$deck-id|position=$position)";
}

multi method get-card-id(Int $position where * <= 14, Int $deck-id, Str $suit, :$minor!) {
    state $get-id-query //= q:to/END-QUERY/;
        SELECT  rowid
        FROM    cards
        WHERE   arcana = 'minor'
            AND suit = ?
            AND deck_id = ?
            AND position = ?
    END-QUERY

    self.DB.query($get-id-query, $suit, $deck-id, $position).arrays.head.head
        // fail "Could not find record for minor arcana (deck_id=$deck-id|position=$position|suit=$suit)";
}

method get-cards(Int $deck-id) {
    state $get-deck-query //= q:to/END-QUERY/;
        SELECT rowid,* FROM cards WHERE deck_id = ?
    END-QUERY

    self.DB.query($get-deck-query, $deck-id).hashes
}