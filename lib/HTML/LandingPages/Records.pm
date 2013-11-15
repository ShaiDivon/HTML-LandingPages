package HTML::LandingPages::Records;
use strict;
use Carp;


sub new {
    my $class=shift;
    my $self = bless {
		type => $_[0]->{type},
		path => $_[0]->{path},
		encoding => $_[0]->{encoding} || 'utf8',
		},$class;
	return $self;
}

sub render {
	my $self=shift;
	my $cgi = shift;
	
    if ( open(RECORDS, ">> :encoding(".$self->{encoding}.")",$self->{path}) ) {
			print RECORDS $self->_timestamp();
			foreach ($cgi->param()) {
				unless ($_ eq 'submited') {
					print RECORDS $self->_recordLine($_,$cgi->param($_))  ||  croak("failed writing");
				}
			}
			if ($self->{type} eq 'xml') {print RECORDS "</record>\n";} else {print RECORDS "\n";}
			close(RECORDS);
        } else {
               croak("Cannot open records file for writing :".$self->{path}." $!\n");
        }
}


sub _recordLine {
	my ($self,$name,$value)=@_;
	return "<$name>$value</$name>" if ($self->{type} eq 'xml');
	return "$name=$value,";
}
 

sub _timestamp {
	my $self=shift;
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime(time);
	$year = $year + 1900;
	$mon += 1;
	my $timestamp = "$mday/$mon/$year $hour:$min:$sec";
	return "<record time='$timestamp'>" if ($self->{type} eq 'xml');
	return $timestamp.",";
}

1;