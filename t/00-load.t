#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 6;

BEGIN {
    use_ok( 'HTML::LandingPages' ) || print "Bail out!\n";
    use_ok( 'HTML::LandingPages::Entity' ) || print "Bail out!\n";
    use_ok( 'HTML::LandingPages::HtmlForm' ) || print "Bail out!\n";
    use_ok( 'HTML::LandingPages::Javascript' ) || print "Bail out!\n";
    use_ok( 'HTML::LandingPages::Records' ) || print "Bail out!\n";
    use_ok( 'HTML::LandingPages::Template' ) || print "Bail out!\n";
}

diag( "Testing HTML::LandingPages $HTML::LandingPages::VERSION, Perl $], $^X" );
