use v6.d;

use DB::SQLite;
use Resource::Wrangler;

module Tarot::Party::DB {}

sub EXPORT(&resources = { %?RESOURCES }) {
    Map.new:
        'W' => Resource::Wrangler[&resources].new
}