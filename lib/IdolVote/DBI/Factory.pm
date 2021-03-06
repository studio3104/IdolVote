package IdolVote::DBI::Factory;

use strict;
use warnings;
use utf8;

use IdolVote::Config;
use Carp ();

use Scope::Container::DBI;

sub new {
    my ($class) = @_;
    return bless +{}, $class;
}

sub dbconfig {
    my ($self, $name) = @_;
    my $dbconfig = config->param('db') // Carp::croak 'required db setting';
    return $dbconfig->{$name} // Carp::croak qq(db config for '$name' does not exist);
}

sub dbh {
    my ($self, $name) = @_;

    my $db_config = $self->dbconfig($name);
    my $user      = $db_config->{user} // Carp::croak qq(user for '$name' does not exist);
    my $password  = $db_config->{password} // Carp::croak qq(password for '$name' does not exist);
    my $dsn       = $db_config->{dsn} // Carp::croak qq(dsn for '$name' does not exist);

    my $dbh = Scope::Container::DBI->connect($dsn, $user, $password, {
        RootClass => 'IdolVote::DBI',
    });
    return $dbh;
}

1;
