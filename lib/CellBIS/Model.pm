package CellBIS::Model;
use strict;
use warnings FATAL => 'all';

# Import Module :
use Carp ();
use Hash::Merge qw( merge );
use CellBIS::Utils::Char;

# Version :
our $VERSION = '0.1000';

# Declare :
our $_setting = {};
our $_config = {};
our $_models = {};
our $_models_size = {};
sub _for;

# Subroutine for setting Model :
# ------------------------------------------------------------------------
sub _setting {
    # Define parameter subroutine :
    my ($self, $setting) = @_;
    Carp::croak(q{$setting is required})
        unless defined $setting && ref($setting) eq 'HASH';
    my %set_setting = %{ merge($_setting, $setting) };
    $_setting = \%set_setting;
}
# End of Subroutine for setting Model.
# ===========================================================================================================

# Subroutine for add model based controller :
# ------------------------------------------------------------------------
sub _for {
    my $self = shift;
    my $param_len = scalar @_;
    if ($param_len == 3) {
        my %cfg = ();
        $cfg{$_[0]} = $_[2];
        my %set_config = %{ merge( $_config, \%cfg ) };
        $_config = \%set_config;
    }

    my %data = ();
    $data{$_[0]} = $_[1];
    my %add_models = %{ merge($_models, \%data) };
    $_models = \%add_models;

    # Size each route :
    my $model = $_[0];
    $model =~ s/^\///g;
    $model =~ s/\/$//g;
    my @_model = CellBIS::Utils::Char->split_bchar($model, '/');
    my %_mdl_size = (
        $_[0] => scalar @_model
    );
    my %mdl_size = %{ merge( $_models_size, \%_mdl_size) };
    $_models_size = \%mdl_size;
}
# End of Subroutine for add model based controller.
# ===========================================================================================================

# Subroutine for models Utils :
# ------------------------------------------------------------------------
sub get_list { return $_models }
sub get_size { return $_models_size }
sub get_cfg { return $_config }
sub get_settings { return $_setting }
# End of Subroutine for models Utils.
# ===========================================================================================================

1;
__END__
#