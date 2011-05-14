use strict;
use warnings;

use Test::More tests => 3;
use Linux::Prctl qw(:constants :functions);

is(get_name, "perl", "Name initially should be perl");
is(set_name("p3rl"), 0, "Setting name to p3rl");
is(get_name, "p3rl", "Name should now be p3rl");
