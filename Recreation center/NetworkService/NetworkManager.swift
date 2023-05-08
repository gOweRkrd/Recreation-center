import Foundation

protocol NetworkManagerType {
    func fetchData(from urlString: String, httpMethod: HTTPMethod) async throws -> Data
}

final class NetworkManager: NetworkManagerType {
    
    func fetchData(from urlString: String, httpMethod: HTTPMethod) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: R.NetworkManager.invalidUrl, code: 0, userInfo: nil)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: R.NetworkManager.invalidResponse, code: 0, userInfo: nil)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "\(R.NetworkManager.statusCode) \(httpResponse.statusCode)", code: 0, userInfo: nil)
        }
        
        return data
    }
}
