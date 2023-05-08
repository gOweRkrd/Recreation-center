import Foundation

enum NetworkServiceError: Error {
    case unknownError
}

protocol NetworkServiceType {
    func fetchData() async throws -> NetworkModel
    func fetchDetail(category: Category?) async throws -> [Object]
}

protocol DetailNetworkServiceType {
    func fetchDetail(category: Category?) async throws -> [Object]
}

final class NetworkService: NetworkServiceType {
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchData() async throws -> NetworkModel {
        do {
            let data = try await networkManager.fetchData(from: "https://rsttur.ru/api/base-app/map", httpMethod: .get)
            let decodedResponse = try JSONDecoder().decode(NetworkModel.self, from: data)
            return decodedResponse
        } catch let error as NetworkError {
            switch error {
            case .networkError:
                    throw NetworkError.networkError
            case .decodingError:
                    throw NetworkError.decodingError
            }
        } catch {
            throw NetworkServiceError.unknownError
        }
    }
}

extension NetworkService: DetailNetworkServiceType {
    func fetchDetail(category: Category?) async throws -> [Object] {
        let data = try await fetchData()
        if let categoriesArray = data.data?.objects {
            if let category = category {
                return categoriesArray.filter { $0.type == category.type }
            } else {
                return categoriesArray
            }
        }
        throw NetworkServiceError.unknownError
    }
}
