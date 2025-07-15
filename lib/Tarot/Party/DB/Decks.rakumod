use v6.d;

use DB::SQLite;
use OO::Monitors;
use Resource::Wrangler;

use Tarot::Party::DB;
use Tarot::Party::DB::Base;

unit monitor Tarot::Party::DB::Decks;
    also does Tarot::Party::DB::Base;

method !load-db {
    DB::SQLite.new: filename => ~ Wrangler.load-resource-to-path("decks.db")
}

method get-deck-id(Str $deck-name) {
    state $get-deck-id-query = q:to/END-QUERY/;
    SELECT rowid from decks where name = ?
END-QUERY

    self.DB.query($get-deck-id-query, $deck-name).arrays.head.head
        // fail "Could not find deck named $deck-name";
}