use v6.*;

use DB::SQLite;

unit role Tarot::Party::DB::Base;

has $!db-handle;

method DB { $!db-handle //= self!load-db }

# Required to be defined all DB types
method !load-db(--> DB::SQLite) { ... }
