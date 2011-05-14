#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <sys/prctl.h>
#include <stdio.h>

MODULE = Linux::Prctl     PACKAGE = Linux::Prctl

int
get_dumpable()
    CODE:
        RETVAL = prctl(PR_GET_DUMPABLE, 0, 0, 0, 0);
    OUTPUT:
        RETVAL

int
set_dumpable(dumpable)
    int dumpable
    CODE:
        RETVAL = prctl(PR_SET_DUMPABLE, dumpable, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_endian()
    CODE:
        int endianness;
        if(prctl(PR_GET_ENDIAN, &endianness, 0, 0, 0))
            XSRETURN_UNDEF;
        RETVAL = endianness;
    OUTPUT:
        RETVAL

int
set_endian(endianness)
    INIT:
        int endianness = 0;
    CODE:
        RETVAL = prctl(PR_SET_ENDIAN, endianness, 0, 0, 0);
    OUTPUT:
        RETVAL

int
ENDIAN_BIG()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_ENDIAN_BIG)));

int
ENDIAN_LITTLE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_ENDIAN_LITTLE)));

int
ENDIAN_PPC_LITTLE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_ENDIAN_PPC_LITTLE)));

int get_fpemu()
    INIT:
        int fpemu = 0;
    CODE:
        if(prctl(PR_GET_FPEMU, &fpemu, 0, 0, 0))
            XSRETURN_UNDEF;
        RETVAL = fpemu;
    OUTPUT:
        RETVAL

int
set_fpemu(fpemu)
    int fpemu
    CODE:
        RETVAL = prctl(PR_SET_FPEMU, fpemu, 0, 0, 0);
    OUTPUT:
        RETVAL

int
FPEMU_NOPRINT()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FPEMU_NOPRINT)));

int
FPEMU_SIGFPE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FPEMU_SIGFPE)));

int get_fpexc()
    INIT:
        int fpexc = 0;
    CODE:
        if(prctl(PR_GET_FPEXC, &fpexc, 0, 0, 0))
            XSRETURN_UNDEF;
        RETVAL = fpexc;
    OUTPUT:
        RETVAL

int
set_fpexc(fpexc)
    int fpexc
    CODE:
        RETVAL = prctl(PR_SET_FPEXC, fpexc, 0, 0, 0);
    OUTPUT:
        RETVAL

int
FPEXC_SW_ENABLE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_SW_ENABLE)));

int
FPEXC_DIV()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_DIV)));

int
FPEXC_OVF()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_OVF)));

int
FPEXC_UND()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_UND)));

int
FPEXC_RES()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_RES)));

int
FPEXC_INV()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_INV)));

int
FPEXC_DISABLED()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_DISABLED)));

int
FPEXC_NONRECOV()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_NONRECOV)));

int
FPEXC_ASYNC()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_ASYNC)));

int
FPEXC_PRECISE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_FP_EXC_PRECISE)));

# New in 2.6.32, but named and implemented inconsistently. The linux
# implementation has two ways of setting the policy to the default, and thus
# needs an extra argument. We ignore the first argument and always all
# PR_MCE_KILL_SET. This makes our implementation simpler and keeps the prctl
# interface more consistent
#ifdef PR_MCE_KILL
#define PR_GET_MCE_KILL PR_MCE_KILL_GET
#define PR_SET_MCE_KILL PR_MCE_KILL
int
set_mce_kill(mce_kill)
    int mce_kill
    CODE:
        RETVAL = prctl(PR_SET_MCE_KILL, PR_MCE_KILL_SET, mce_kill, 0, 0);
    OUTPUT:
        RETVAL

int
get_mce_kill()
    CODE:
        RETVAL = prctl(PR_GET_MCE_KILL, 0, 0, 0, 0);
    OUTPUT:
        RETVAL

int
MCE_KILL_DEFAULT()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_MCE_KILL_DEFAULT)));

int
MCE_KILL_EARLY()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_MCE_KILL_EARLY)));

int
MCE_KILL_LATE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_MCE_KILL_LATE)));

#endif

char *
get_name()
    INIT:
        char *name = (char*)malloc(32);
    CODE:
        prctl(PR_GET_NAME, name, 0, 0, 0);
        RETVAL = name;
    OUTPUT:
        RETVAL

int
set_name(name)
    char *name
    CODE:
        RETVAL = prctl(PR_SET_NAME, name, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_pdeathsig()
    INIT:
        int signal;
    CODE:
        prctl(PR_GET_PDEATHSIG, &signal, 0, 0, 0);
        RETVAL = signal;
    OUTPUT:
        RETVAL

int
set_pdeathsig(signal)
    int signal
    CODE:
        RETVAL = prctl(PR_SET_PDEATHSIG, signal, 0, 0, 0);
    OUTPUT:
        RETVAL

#ifdef PR_SET_PTRACER
int
set_ptracer(pid)
    int pid
    CODE:
        RETVAL = prctl(PR_SET_PTRACER, pid, 0, 0, 0);
    OUTPUT:
        RETVAL

#endif

#ifdef PR_SET_SECCOMP
int
set_seccomp(val)
    int val
    CODE:
        RETVAL = prctl(PR_SET_SECCOMP, val, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_seccomp()
    CODE:
        RETVAL = prctl(PR_GET_SECCOMP, 0, 0, 0, 0);
    OUTPUT:
        RETVAL

#endif

#ifdef PR_GET_TIMERSLACK
int
set_timerslack(timerslack)
    int timerslack
    CODE:
        RETVAL = prctl(PR_SET_TIMERSLACK, timerslack, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_timerslack()
    CODE:
        RETVAL = prctl(PR_GET_TIMERSLACK, 0, 0, 0, 0);
    OUTPUT:
        RETVAL

#endif

int
set_timing(timing)
    int timing
    CODE:
        RETVAL = prctl(PR_SET_TIMING, timing, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_timing()
    CODE:
        RETVAL = prctl(PR_GET_TIMING, 0, 0, 0, 0);
    OUTPUT:
        RETVAL

int
TIMING_STATISTICAL()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_TIMING_STATISTICAL)));

int
TIMING_TIMESTAMP()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_TIMING_TIMESTAMP)));

#ifdef PR_SET_TSC
int
set_tsc(tsc)
    int tsc
    CODE:
        RETVAL = prctl(PR_SET_TSC, tsc, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_tsc()
    CODE:
        int tsc;
        prctl(PR_GET_TSC, &tsc, 0, 0, 0);
        RETVAL = tsc;
    OUTPUT:
        RETVAL

int
TSC_ENABLE()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_TSC_ENABLE)));

int
TSC_SIGSEGV()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_TSC_SIGSEGV)));

#endif

int
set_unalign(unalign)
    int unalign
    CODE:
        RETVAL = prctl(PR_SET_UNALIGN, unalign, 0, 0, 0);
    OUTPUT:
        RETVAL

int
get_unalign()
    CODE:
        int unalign;
        prctl(PR_GET_UNALIGN, &unalign, 0, 0, 0);
        RETVAL = unalign;
    OUTPUT:
        RETVAL

int
UNALIGN_NOPRINT()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_UNALIGN_NOPRINT)));

int
UNALIGN_SIGBUS()
    PPCODE:
        PUSHs(sv_2mortal(newSViv(PR_UNALIGN_SIGBUS)));

