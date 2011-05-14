package Linux::Prctl;

use 5.008005;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaratio use Linux::Prctl ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = (
'constants' => [ qw(
        ENDIAN_BIG
        ENDIAN_LITTLE
        ENDIAN_PPC_LITTLE
        FPEMU_NOPRINT
        FPEMU_SIGFPE
        FPEXC_SW_ENABLE
        FPEXC_DIV
        FPEXC_OVF
        FPEXC_UND
        FPEXC_RES
        FPEXC_INV
        FPEXC_DISABLED
        FPEXC_NONRECOV
        FPEXC_ASYNC
        FPEXC_PRECISE
        TIMING_STATISTICAL
        TIMING_TIMESTAMP
    )],
'functions' => [ qw(
        get_dumpable
        set_dumpable
        get_endian
        set_endian
        get_fpemu
        set_fpemu
        get_fpexc
        set_fpexc
        get_name
        set_name
        get_pdeathsig
        set_pdeathsig
        get_timing
        set_timing
    )]
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{constants} }, @{ $EXPORT_TAGS{functions} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.50';

require XSLoader;
XSLoader::load('Linux::Prctl', $VERSION);

# Some functions may not be defined, we want to stay compatible
# with centos 5, which uses linux 2.6.18. Anything newer than that is
# guarded with #ifdef's 
for('get_mce_kill', 'set_mce_kill', 'set_ptracer', 'get_seccomp', 'set_seccomp',
    'get_timerslack', 'set_timerslack', 'get_tsc', 'set_tsc',
    'get_unalign', 'set_unalign') {
    if(__PACKAGE__->can($_)) {
        push @EXPORT_OK, $_;
        push @{$EXPORT_TAGS{functions}}, $_;
    }
}
for('MCE_KILL_DEFAULT', 'MCE_KILL_EARLY', 'MCE_KILL_LATE', 'TSC_ENABLE', 'TSC_SIGSEGV',
    'UNALIGN_NOPRINT', 'UNALIGN_SIGBUS') {
    if(__PACKAGE__->can($_)) {
        push @EXPORT_OK, $_;
        push @{$EXPORT_TAGS{constants}}, $_;
    }
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Linux::Prctl - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Linux::Prctl;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Linux::Prctl, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Dennis Kaarsemaker, E<lt>dennis@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Dennis Kaarsemaker

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
