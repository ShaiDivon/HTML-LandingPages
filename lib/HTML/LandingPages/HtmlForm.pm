package HTML::LandingPages::HtmlForm;


use HTML::LandingPages::Entity;
use HTML::LandingPages::Javascript;

our @ISA = qw(HTML::LandingPages::Entity); 

use strict;

sub new {
    
	my $class=shift;
    my $self = bless {
		formsInputs  => $_[0]->{formsInputs},
		submitMethod => $_[0]->{submitMethod} || 'get', 
		onSuccess    => $_[0]->{onSuccess} || 'submited',
		onFailed     => $_[0]->{onFailed} || 'Oppss...',
		path         => $_[0]->{path},
		}, $class;
    
	return  $self;

}




sub render {
	my $self=shift;
	my $htmlForm = $self->SUPER::render(@_);
	return $htmlForm;
}
	
sub renderDefault {
	my $self=shift; 
	my $formsInputs = $self->{formsInputs};
	my $htmlForm = "<div><form>";
	$htmlForm .= "<label for=\"$_\">$_: </label><input type=\"text\" name=\"$_\"/>"
		foreach (@$formsInputs);
	$htmlForm .= "<input type=\"submit\" value=\"Submit\" class=\"submit\"/>";
	$htmlForm .= "</form></div>";
	return $htmlForm;
}



sub DESTROY()
{
}
 



1;
