
use Test;

use Tarot::Spread;

{
    my class InternalExternal does Tarot::Spread {
        method placements { [ :Internal(2), :Topic(1), :External(3) ] }
    }

    ok InternalExternal.placements[0] ~~ :Internal(2),
        "Placements work as expected";
}

done-testing;