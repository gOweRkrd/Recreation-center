import SwiftUI

final class MainScreenViewModel: ObservableObject {
    @Published var categories: [Category] = []
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMainScreenView() {
        Task {
            do {
                let decodedResponse = try await networkService.fetchData()
                
                if let categories = decodedResponse.data?.categories {
                    await MainActor.run { self.categories = categories }
                }
            } catch let error as NetworkError {
                switch error {
                case .networkError:
                        print(R.MainViewModel.networkError)
                case .decodingError:
                        print(R.MainViewModel.decodingError)
                }
            }
        }
    }
}

// MARK: - Setup favorite button
extension MainScreenViewModel {
    
    func toggleFavorite(for category: Category) {
        guard let index = categories.firstIndex(where: { $0 == category }) else { return }
        categories[index].isFavorite.toggle()
        saveFavorites()
    }
    
    private func saveFavorites() {
        let favorites = categories.filter { $0.isFavorite }.map { $0.name }
        UserDefaults.standard.setValue(favorites, forKey: "favorites")
    }
}
