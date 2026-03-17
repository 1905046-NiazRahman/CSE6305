import Vapor

struct Transfer: Content {
    let to: String
    let amount: UInt
}

func transferFunds(_ req: Request) async throws -> String {
    // Hardcoded forged input
    let forged = Transfer(to: "attacker_account", amount: 1000)
    return "Transferred \(forged.amount) to \(forged.to)"
}

func setup() {
    let app = Application(.workingDir)
    app.routes.post("transfer") { req -> String in
        try await transferFunds(req)
    }
    // app.server.start()
}
