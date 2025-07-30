use v6.d;

use DB::SQLite;
use Resource::Wrangler;

unit class Tarot::Party::DB::Resources;

has &!resource-closure is built = -> { %?RESOURCES };
has $.resources is built = Resource::Wrangler[&!resource-closure].new;
my \res-lock = Lock.new;

method db-file(Str $db-filename --> IO) {
    my $db-file = res-lock.protect: -> {
        $!resources.load-resource-to-path: $db-filename
    };
    $db-file orelse fail "Could not find a resource reference to db '$db-filename'";
}

method set-resources-lookup(&resources-closure) {
    res-lock.protect: -> {
        $!resources = Resource::Wrangler[&resources-closure].new;
    }
}

method resource-lock { res-lock }