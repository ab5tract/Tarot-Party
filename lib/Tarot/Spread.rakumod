use v6.d;

unit role Tarot::Spread;

has @.order is built;       #| [ 3 ] == one row, three cards
has @.placements is built;  #| for the names of the placements. must be the same shape as @!order
