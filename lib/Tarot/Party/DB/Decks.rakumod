use v6.d;

use DB::SQLite;
use Resource::Wrangler;

use Tarot::Party::DB::Base;

unit class Tarot::Party::DB::Decks;
    also does Tarot::Party::DB::Base;

method new(*%building) {
    self.bless: |%building, :db-name<cards.db>;
}

method get-deck-id(Str $deck-name) {
    state $get-deck-id-query = q:to/END-QUERY/;
        SELECT rowid from decks where name = ?
    END-QUERY

    self.DB.query($get-deck-id-query, $deck-name).arrays.head.head
        // fail "Could not find deck named $deck-name";
}

method get-deck(Int $deck-id) {
    state $get-deck-query //= q:to/END-QUERY/;
        SELECT rowid,* FROM cards WHERE deck_id = ?
    END-QUERY

    self.DB.query($get-deck-query, $deck-id).hashes
}