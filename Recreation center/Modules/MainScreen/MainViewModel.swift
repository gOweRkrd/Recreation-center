import SwiftUI

final class MainScreenViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    func fetchCategories() {
        guard let url = URL(string: "https://rsttur.ru/api/base-app/map") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(NetworkModel.self, from: data)
                if let categoriesArray = decodedData.data?.categories {
                    DispatchQueue.main.async {
                        self.categories = categoriesArray
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}
