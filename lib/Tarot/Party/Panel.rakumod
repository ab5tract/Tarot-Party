use v6.d;

use GTK::Simple::Frame;

unit role Tarot::Party::Panel;
    also is GTK::Simple::Frame;

method !assemble-panel(--> GTK::Simple::Widget) { ... }

