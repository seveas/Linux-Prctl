use strict;
use warnings;

use Test::More tests => 24;
use Linux::Prctl;

SKIP: { 
    open(my $fh, '<', '/usr/include/linux/prctl.h') or
    skip "prctl.h not available", 24;

    my %consts;
    while(<$fh>) {
        if(/^#\s*define\s+([A-Z_]+)\s+([0-9]+|0x[0-9a-fA-F]+)(?:\s|$|\/)/) {
            $consts{$1} = eval($2);
        }
    }

    is(Linux::Prctl::ENDIAN_BIG, $consts{PR_ENDIAN_BIG}, "ENDIAN_BIG correctly defined");
    is(Linux::Prctl::ENDIAN_LITTLE, $consts{PR_ENDIAN_LITTLE}, "ENDIAN_LITTLE correctly defined");
    is(Linux::Prctl::ENDIAN_PPC_LITTLE, $consts{PR_ENDIAN_PPC_LITTLE}, "ENDIAN_PPC_LITTLE correctly defined");
    is(Linux::Prctl::FPEMU_NOPRINT, $consts{PR_FPEMU_NOPRINT}, "FPEMU_NOPRINT correctly defined");
    is(Linux::Prctl::FPEMU_SIGFPE, $consts{PR_FPEMU_SIGFPE}, "FPEMU_SIGFPE correctly defined");
    is(Linux::Prctl::FPEXC_SW_ENABLE, $consts{PR_FP_EXC_SW_ENABLE}, "FPEXC_SW_ENABLE correctly defined");
    is(Linux::Prctl::FPEXC_DIV, $consts{PR_FP_EXC_DIV}, "FPEXC_DIV correctly defined");
    is(Linux::Prctl::FPEXC_OVF, $consts{PR_FP_EXC_OVF}, "FPEXC_OVF correctly defined");
    is(Linux::Prctl::FPEXC_UND, $consts{PR_FP_EXC_UND}, "FPEXC_UND correctly defined");
    is(Linux::Prctl::FPEXC_RES, $consts{PR_FP_EXC_RES}, "FPEXC_RES correctly defined");
    is(Linux::Prctl::FPEXC_INV, $consts{PR_FP_EXC_INV}, "FPEXC_INV correctly defined");
    is(Linux::Prctl::FPEXC_DISABLED, $consts{PR_FP_EXC_DISABLED}, "FPEXC_DISABLED correctly defined");
    is(Linux::Prctl::FPEXC_NONRECOV, $consts{PR_FP_EXC_NONRECOV}, "FPEXC_NONRECOV correctly defined");
    is(Linux::Prctl::FPEXC_ASYNC, $consts{PR_FP_EXC_ASYNC}, "FPEXC_ASYNC correctly defined");
    is(Linux::Prctl::FPEXC_PRECISE, $consts{PR_FP_EXC_PRECISE}, "FPEXC_PRECISE correctly defined");
    is(Linux::Prctl::MCE_KILL_DEFAULT, $consts{PR_MCE_KILL_DEFAULT}, "MCE_KILL_DEFAULT correctly defined");
    is(Linux::Prctl::MCE_KILL_EARLY, $consts{PR_MCE_KILL_EARLY}, "MCE_KILL_EARLY correctly defined");
    is(Linux::Prctl::MCE_KILL_LATE, $consts{PR_MCE_KILL_LATE}, "MCE_KILL_LATE correctly defined");
    is(Linux::Prctl::TIMING_STATISTICAL, $consts{PR_TIMING_STATISTICAL}, "TIMING_STATISTICAL correctly defined");
    is(Linux::Prctl::TIMING_TIMESTAMP, $consts{PR_TIMING_TIMESTAMP}, "TIMING_TIMESTAMP correctly defined");
    is(Linux::Prctl::TSC_ENABLE, $consts{PR_TSC_ENABLE}, "TSC_ENABLE correctly defined");
    is(Linux::Prctl::TSC_SIGSEGV, $consts{PR_TSC_SIGSEGV}, "TSC_SIGSEGV correctly defined");
    is(Linux::Prctl::UNALIGN_NOPRINT, $consts{PR_UNALIGN_NOPRINT}, "UNALIGN_NOPRINT correctly defined");
    is(Linux::Prctl::UNALIGN_SIGBUS, $consts{PR_UNALIGN_SIGBUS}, "UNALIGN_SIGBUS correctly defined");
}
