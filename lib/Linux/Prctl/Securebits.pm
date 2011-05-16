package Linux::Prctl::Securebits;
use Tie::Hash;

use vars qw(@ISA);
@ISA = qw(Tie::StdHash);

sub new {
    require Linux::Prctl;
    my ($class) = @_;
    my $self = {};
    return bless($self, $class);
}

sub bits {
    return {
        'keep_caps' => Linux::Prctl->can('SECURE_KEEP_CAPS')->(),
        'keep_caps_locked' => Linux::Prctl->can('SECURE_KEEP_CAPS_LOCKED')->(),
        'noroot' => Linux::Prctl->can('SECURE_NOROOT')->(),
        'noroot_locked' => Linux::Prctl->can('SECURE_NOROOT_LOCKED')->(),
        'no_setuid_fixup' => Linux::Prctl->can('SECURE_NO_SETUID_FIXUP')->(),
        'no_setuid_fixup_locked' => Linux::Prctl->can('SECURE_NO_SETUID_FIXUP_LOCKED')->(),
    }
}

sub set_securebits {
    shift;
    return Linux::Prctl->can('set_securebits')->(@_);
}

sub get_securebits {
    shift;
    return Linux::Prctl->can('get_securebits')->(@_);
}

sub STORE {
    my ($self, $key, $value) = @_;
    $key = $self->bits->{$key} if exists $self->bits->{$key};
    my $nbits = $self->get_securebits();
    $nbits |= (1 << $key) if $value;
    $nbits ^= (1 << $key) if (($nbits & (1 << $key)) && !$value);
    $self->set_securebits($nbits);
}

sub FETCH {
    my ($self, $key) = @_;
    $key = $self->bits->{$key} if exists $self->bits->{$key};
    return ($self->get_securebits() & (1 << $key)) ? 1 : 0;
}

1;

