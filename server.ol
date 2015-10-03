include "console.iol"
include "interface.iol"

inputPort BankService {
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: BankInterface
}

cset {
	sid:OpMessage.sid
		ReportRequest.sid
 		DepositRequest.sid
 		WdRequest.sid
}

execution{ concurrent }

init {
	keepRunning = true
}

main
{
	login( request )( response ){
		username = request.name;
		response.sid = csets.sid = new;
		response.message = "You are logged in."
	};
	while( keepRunning ){
		[report( request )( response )]{
			println@Console( "report")()
		}	
		[ deposit( request )( response ) ]{
			println@Console( "deposit")()
		}
		[ wd( request )( response ) ]{
			println@Console( "wd")()
		}
		[ logout( request ) ] { 
			println@Console("User "+username+" logged out.")();
			keepRunning = false }
	}
}