type LoginRequest: void {
	.name: string
}

type OpMessage: void{
	.sid: string
	.message?: string
}

type WdRequest: void{
	.sid: string
	.amount: double
}
type DepositRequest : void{
	.sid: string
	.amount: double
}
type ReportRequest: void{
	.sid: string
	.message: string
}

interface BankInterface {
	RequestResponse: login(LoginRequest)(OpMessage), wd(WdRequest)(OpMessage), deposit(DepositRequest)(OpMessage), report(ReportRequest)(double)
	OneWay: logout(OpMessage)
}
