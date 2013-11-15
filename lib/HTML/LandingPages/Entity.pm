package HTML::LandingPages::Entity;

use strict;
use warnings;
use Carp;

sub name {
	my $self=shift;
	if (defined $_[0]) {
		$self->{name}=$_[0];
	}
	$self->{name};
}

sub path {
	my $self=shift;
	if (defined $_[0]) {
		$self->{path}=$_[0];
	}
	$self->{path};
}


sub render {
	my ($self, $path)=@_;
	return undef unless (defined $path);
	my $tmpl;
	my $separator =$/;
	undef $/;
	open(TEMPLATE, "<".$path) 
		|| croak("Cannot open html template file:$path $!\n");
	$tmpl = <TEMPLATE>;
	close TEMPLATE;
	$/=$separator;
	return $tmpl;
}



1;