use strict;
use warnings;

use Test::More tests => 20;
use POSIX qw(uname SIGHUP);
use Linux::Prctl qw(:constants :functions);

my $arch = uname;

SKIP: {
    skip "get_fpexc/set_fpexc are powerpc specific", 20 unless $arch eq 'powerpc';
    for(FPEXC_SW_ENABLE, FPEXC_DIV, FPEXC_OVF, FPEXC_UND, FPEXC_RES, FPEXC_INV, FPEXC_DISABLED, FPEXC_NONRECOV, FPEXC_ASYNC, FPEXC_PRECISE) {
        is(set_fpexc($_), 0, "Setting fpexc to $_");
        is(get_fpexc, $_, "Checking whether fpexc is $_");
    }
}
