package HTML::LandingPages;

use 5.006;
use strict;
use warnings FATAL => 'all';

=head1 NAME

HTML::LandingPages - The great new HTML::LandingPages!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

HTML::LandingPages offers a simple way for creating Landing pages (it even comes with pre made easy to use default template), 
a built in A/B testing for optimization, javascript support for ajax submission, and ability to store the "user records" to file

use CGI qw(:standard);
use HTML::LandingPages;
print header;


my $lp = HTML::LandingPages->new (
	{
		templates=> [
			{path =>'templates/landingPageVer1.html',percent => '70'},
			{path =>'templates/landingPageVer2.html',percent => '30'},
			],
		form=> {
				path => 'forms/form.html',
				submitMethod=>'get'
				onSuccess=> '<b>Thanks, submited <font color="red" size="5">successfully</font><br /><br />',
				onFailed => '<font color="red" size="5">Opps, the data was *not* saved!</font><br>Please try resubmit?',
			},
		records =>{
				type=>'csv',  
				path=>'records/users.txt',
			},
	}
);

print $lp;



=head1 AUTHOR

Shai Divon, C<< <shaidivon at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-html-landingpages at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=HTML-LandingPages>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc HTML::LandingPages


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=HTML-LandingPages>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/HTML-LandingPages>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/HTML-LandingPages>

=item * Search CPAN

L<http://search.cpan.org/dist/HTML-LandingPages/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Shai Divon.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of HTML::LandingPages
