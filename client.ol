include "console.iol"
include "ui/ui.iol"
include "ui/swing_ui.iol"
include "interface.iol"

outputPort BankService {
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: BankInterface
}

main
{
	showInputDialog@SwingUI( "Insert your name" )( request.name );
	keepRunning = true;
	login@BankService( request )( response );
	opMessage.sid = response.sid;
	println@Console( "Server Responded: " + response.message + "\t sid: "+opMessage.sid )();
	while( keepRunning ){
		showInputDialog@SwingUI( "Insert a command:\n- \"logout\" for logging out\n- \"wd\" for a withdrawal operation\n- \"deposit\" for a deposit operation\n- \"report\" for a account report operation")( opMessage.message );




		if( opMessage.message == "logout" ){
			logout@BankService( opMessage );
			keepRunning = false		
		} else if ( opMessage.message == "wd" ) {
			// Create withdrawal request obj 
			wdReq.sid = opMessage.sid;
			showInputDialog@SwingUI( "Insert the amount for withdrawal" )( a );
			wdReq.amount = double(a);
			// send request
			wd@BankService( wdReq )(response);
			// print response
			println@Console( "Server Responded: " + response.message + "\t sid: "+response.sid )()
		
		} else if ( opMessage.message == "deposit" ) {
			// Create deposit request obj 
			depositReq.sid = opMessage.sid;
			showInputDialog@SwingUI( "Insert the amount for deposit" )( a );
			depositReq.amount = double(a);
			// send request
			deposit@BankService( depositReq )(response);
			// print response
			println@Console( "Server Responded: " + response.message + "\t sid: "+response.sid )()

		} else if ( opMessage.message == "report" ) {
			// Create report request obj 
			reportReq.sid = opMessage.sid;
			reportReq.message = "";
			// send request
			deposit@BankService( reportReq )(response);
			// print response
			println@Console( "Server Responded: " + response.message + "\t sid: "+response.sid )()
		}
	}
}