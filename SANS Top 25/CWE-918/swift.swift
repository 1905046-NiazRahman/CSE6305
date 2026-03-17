import Vapor

func routes(_ app: Application) throws {
    app.get("test") { req async throws -> String in
        let client = try app.client()
        
        // Benign request
        let benignURL = "https://example.com"
        let benignResp = try await client.get(url: benignURL).getResponse()
        let benignStatus = benignResp.status.code
        
        // Malicious SSRF to internal metadata (no protection)
        let maliciousURL = "http://169.254.169.254/latest/meta-data/"
        let ssrfResp = try await client.get(url: maliciousURL).getResponse()
        let ssrfStatus = ssrfResp.status.code
        let ssrfBody = try await ssrfResp.body.string()
        
        return "Benign: \(benignStatus), SSRF: \(ssrfStatus), Body: \(ssrfBody)"
    }
}
