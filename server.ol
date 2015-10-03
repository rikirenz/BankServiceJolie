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
		totalBalance = 10;
		username = request.name;
		response.sid = csets.sid = new;
		response.message = "You are logged in."
	};
	while( keepRunning ){
		[report( request )( response1 ){
			println@Console( "report")();
			response1 = totalBalance	
		}]
		[ 
		deposit( request )( response2 ) {
			println@Console( "deposit")();
			totalBalance += request.amount;
			response2.sid = request.sid;
			response2.message = "Your actual amount is:" + totalBalance
		}]
		[ wd( request )( response3 ) {
			println@Console( "wd")();
			totalBalance -= request.amount; 		
			response3.sid = request.sid;
			response3.message = "Your actual amount is:" + totalBalance
		}]
		[ logout( request ) ] { 
			println@Console("User "+username+" logged out.")();
			keepRunning = false }
	}
}