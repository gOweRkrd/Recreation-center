import SwiftUI

final class DetailViewModel: ObservableObject {
    @Published var detailModel = [Object]()
    
    func fetchDetail(category: Category?) {
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
                if let categoriesArray = decodedData.data?.objects {
                    DispatchQueue.main.async {
                        if let category = category {
                            self.detailModel = categoriesArray.filter { $0.type == category.type }
                        } else {
                            self.detailModel = categoriesArray
                        }
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
}
