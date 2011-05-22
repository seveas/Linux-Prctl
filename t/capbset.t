use strict;
use warnings;

use Test::More tests => 69;
use Linux::Prctl qw(:constants);

SKIP: {
    skip "capbset_drop not available", 35 unless Linux::Prctl->can('capbset_drop');
    is(defined(tied %Linux::Prctl::capbset), 1, "Have a tied capbset object");
    for(@{$Linux::Prctl::EXPORT_TAGS{capabilities}}) {
        s/^CAP_//;
        $_ = lc($_);
        is($Linux::Prctl::capbset{$_}, 1, "Checking whether $_ is in the bounding set");
    }
}

SKIP: {
    skip "capbset_drop not available", 34 unless Linux::Prctl->can('capbset_drop');
    skip "Drop tests only makes sense when run as root", 34 unless $< == 0;
    for(@{$Linux::Prctl::EXPORT_TAGS{capabilities}}) {
        s/^CAP_//;
        $_ = lc($_);
        $Linux::Prctl::capbset{$_} = 0;
        is($Linux::Prctl::capbset{$_}, 0, "Checking whether $_ is no longer in the bounding set");
    }
}
