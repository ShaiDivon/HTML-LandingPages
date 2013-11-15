package HTML::LandingPages::Template;
use strict;
use Carp;

use HTML::LandingPages::Entity;
our @ISA = qw(HTML::LandingPages::Entity); 

sub new {
    my $class=shift;
    my $self = bless _setTemplates(shift),$class;
	return $self;
}

sub pickTemplate {
	my $self=shift;
    my ($lowLimit,$intRandomNumber)=(0,int(100*rand));
	my @randTemplate = grep {  
		my $picked = ($intRandomNumber >= $lowLimit) &&  ($intRandomNumber <  $lowLimit + $_->{percent}) ; 
		$lowLimit+=$_->{percent}; 
		$picked;
		} @$self;
	return $randTemplate[0];
}


sub _setTemplates {
	my $templates =shift;
	if (ref $templates eq 'ARRAY') {
	return _percentNormalized([ map {
		ref $templates->[$_] eq 'HASH' ? {
			name => $templates->[$_]->{name} || 'template'.(1+$_),
			path    => $templates->[$_]->{path} || undef , 
			h1 => $templates->[$_]->{h1},
			title => $templates->[$_]->{title},
			body =>$templates->[$_]->{body},
			percent  => $templates->[$_]->{percent} } : {path=> $templates->[$_], percent=>0}} (0..$#{$templates})
		]);
    } elsif (ref $templates eq 'HASH') {
		return [{
			name=> $templates->{name},
			path=>$templates->{path},
			percent=>$templates->{percent}||100,
			h1=>$templates->{h1},
			title=>$templates->{title},
			}]
	}
	else { 
		return [
		{
		path=>undef,
		percent=>100,
		h1=>undef, 
		title=>undef, 
		name=> 'default'
		}
		]
	}   
}


sub _percentNormalized {
    my $templates=shift; 
    my ($totalpercent, $percentLessCounter) = (0,0);  
	foreach (0..$#$templates) {
		my $percent  = $templates->[$_]->{percent} ;
		$percentLessCounter++ unless $percent;
		$totalpercent += $percent;
	};
	my $percentLeft = $totalpercent > 100 ? 0 : 100-$totalpercent;
	my $avgPerTemplate  = $percentLessCounter ? $percentLeft / $percentLessCounter : 0;
	my $factor = $avgPerTemplate ? 1 : $totalpercent ? 100 / $totalpercent  : 1;
	$templates->[$_]->{percent} =  $templates->[$_]->{percent} ?  $templates->[$_]->{percent} *  $factor : $avgPerTemplate
		foreach (0..$#$templates);
    return $templates;

}

sub renderDefault {
	my ($self,$templateData)=@_;
	return <<HTML;
<!DOCTYPE html>
<html>
	<head>
	  <meta charset="utf-8" />
		<title>$templateData->{title}</title>  
		<meta name="keywords" content="$templateData->{keywords}" />
		<meta name="description" content="$templateData->{description}" />
		<meta name="robots" content="$templateData->{robots}" />
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	  
		<style type="text/css">
			input{display:block;margin-bottom:6px;}
			input.submit{margin-bottom:15px;position:relative;left:25px;}
			label{width:70px;float:left;text-align:right;margin-right:30px;}
		</style>
	</head>
	<body>
		<div style="width:645px;margin:20px auto 0;box-shadow: 0px 0px 5px;background:#fffff;">
		<div style="padding:30px;overflow:hidden;">
		<h1>$templateData->{h1}</h1>
		<div style="height:1px;border-bottom:1px dotted;margin:10px 0 20px;">&nbsp;</div>
		$templateData->{body}
		<div>
			<p>please complite the form bellow:</p>
			__LANDINGFORM__
		</div>
		<div style="font-size:11px;text-align:center;">HTML::LandingPages</div>
		</div>
		</div>
	</body>
</html> 
HTML
}

sub DESTROY()
{
}
 

1;
