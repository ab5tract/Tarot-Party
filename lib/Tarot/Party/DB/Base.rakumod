use v6.*;

use DB::SQLite;
use Tarot::Party::DB::Resources;

unit role Tarot::Party::DB::Base;

#Pass a mocked resource lookup to the resource manager
#constructor for testing / custom DB locations
has $!db-resources is built = Tarot::Party::DB::Resources.new;
has $!db-name is built is required;
has $!db-handle = self!load-db;

#method DB { $!db-handle ||= self!load-db }
method DB { $!db-handle }

#XXX: Untangle the resources from the DB classes
method get-resource-path(Str $resource) {
    $!db-resources.db-file: $resource
}

#Required to be defined all DB types
method !load-db(--> DB::SQLite) {
    $!db-handle //= do {
        my $filename = ~ $!db-resources.db-file($!db-name);
        DB::SQLite.new: :$filename;
    }
}
