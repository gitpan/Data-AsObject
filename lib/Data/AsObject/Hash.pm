package Data::AsObject::Hash;

use strict;
use warnings;
use Carp;
use Scalar::Util qw(reftype blessed);
use Data::AsObject ();
use Data::AsObject::Array ();

our $AUTOLOAD;

sub AUTOLOAD {
	my $self = shift;
	my $index = shift;

	my $key = $AUTOLOAD;
	$key =~ s/.*:://;
	undef $AUTOLOAD;

	if ($key eq "can" && defined $index && $index != /\d+/) {
		return undef;
	}

	if ($key eq "isa" && defined $index && $index != /\d+/) {
		$index eq "Data::AsObject::Hash" or $index eq "UNIVERSAL" 
			? return 1 
			: return 0;
	}

	if ( exists $self->{$key} ) {
			my $data = $self->{$key};

			if (
				   defined $index
				&& $index =~ /\d+/
				&& $Data::AsObject::__check_type->($data) eq "ARRAY"
				&& exists $data->[$index]
			)
			{
				$data = $data->[$index];
			}
			
			if ( $Data::AsObject::__check_type->($data) eq "ARRAY" ) {
				bless $data, "Data::AsObject::Array";
				return wantarray ? $data->all : $data;
			} elsif ( $Data::AsObject::__check_type->($data) eq "HASH" ) {
				return wantarray ? %{$data} : bless $data, "Data::AsObject::Hash";
			} else {
				return $data;
			}
	} else {
		carp "Attempting to access non-existing hash key $key!" unless $key eq "DESTROY";
		return;
	}
}

1;
