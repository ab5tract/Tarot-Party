#!/usr/bin/env raku
use v6.d;

my $create-decks = q:to/END/;
    create table if not exists decks (name text)
END
say "Creating table 'decks'...";
say "\t| $create-decks |";

my $create-cards = q:to/END/;
    create table if not exist cards
        (deck_id integer, arcana text,
END