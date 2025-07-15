use v6.d;

use DB::SQLite;
use Resource::Wrangler;

module Tarot::Party::DB {}

sub EXPORT(:&resources = { %?RESOURCES }) {
    Map.new:
        'Wrangler' => Resource::Wrangler[&resources].new
}