use strict;
use warnings;

use Test::More tests => 10;
use Linux::Prctl qw(:constants :securebits);

SKIP: {
    skip "set_timerslack not available", 10 unless Linux::Prctl->can('set_securebits');
    skip "This test only makes sense when run as root", 10 unless $< == 0;
    is(defined(tied %{$Linux::Prctl::securebits}), 1, "Have a tied securebits object");
    for(qw(keep_caps noroot no_setuid_fixup)) {
        is($Linux::Prctl::securebits->{$_}, 0, "Checking whether $_ is 0");
        $Linux::Prctl::securebits->{$_} = 1;
        is($Linux::Prctl::securebits->{$_}, 1, "Checking whether $_ is 1");
        $Linux::Prctl::securebits->{$_} = 0;
        is($Linux::Prctl::securebits->{$_}, 0, "Checking whether $_ is 0");
    }
}
