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
    
    func changeFavoriteButton(for category: Category) -> some View {
        Image(systemName: category.isFavorite ? "heart.fill" : "heart")
            .foregroundColor(category.isFavorite ? .red : .black)
            .onTapGesture {
                self.toggleFavorite(for: category)
            }
    }
    
    func trashButton(for category: Category) -> some View {
        Button { [self] in
            categories.removeAll(where: { $0 == category })
        } label: {
            Image(systemName: "trash")
        }
        .tint(.red)
    }
    
    func favoriteButton(for category: Category) -> some View {
        Button(
            action: {
                self.toggleFavorite(for: category)
            },
            label: {
                Image(systemName: category.isFavorite ? "heart.fill" : "heart")
            }
        )
    }
    
    private func toggleFavorite(for category: Category) {
        guard let index = categories.firstIndex(where: { $0 == category }) else { return }
        categories[index].isFavorite.toggle()
        saveFavorites()
    }
    
    private func saveFavorites() {
        let favorites = categories.filter { $0.isFavorite }.map { $0.name }
        UserDefaults.standard.setValue(favorites, forKey: "favorites")
    }
}
