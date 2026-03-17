import Foundation
import Network

let listener = try! NWListener(using: .tcp, on: 8080)

listener.stateUpdateHandler = { state in
    switch state {
    case .ready:
        print("Server ready")
    default: break
    }
}

listener.newConnectionHandler = { connection in
    connection.stateUpdateHandler = { state in
        if state == .ready {
            handleConnection(connection)
        }
    }
    connection.start(queue: .main)
}

listener.start(queue: .main)

func handleConnection(_ connection: NWConnection) {
    connection.receiveMessage { (data, _, _, _) in
        // Hardcoded malicious input
        let malicious = "1/0"
        let parts = malicious.components(separatedBy: "/")
        let a = Int(parts[0]) ?? 0
        let b = Int(parts[1]) ?? 1
        let result = a / b  // Runtime crash with stack trace
        
        let response = "Result: \(result)"
        connection.send(content: response.data(using: .utf8)!, completion: .contentProcessed({ _ in }))
    }
    connection.start(queue: .main)
}

dispatchMain()
