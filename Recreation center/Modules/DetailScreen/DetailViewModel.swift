import CoreLocation
import MapKit
import SwiftUI

final class DetailViewModel: ObservableObject {
    @Published var detailModel = [Object]()
    @Published  var images: [URL: UIImage] = [:]
    
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
    
    func loadImage(for item: Object) {
        guard let imageUrl = item.image else { return }
        guard images[imageUrl] == nil else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.images[imageUrl] = UIImage(data: data)
            }
        }
        .resume()
    }
    
    func openInMaps(item: Object) {
        guard let lat = item.lat, let lon = item.lon else {
            return
        }
        // 2GIS
        if let url = URL(string: "dgis://map/?pt=\(lon),\(lat)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Handle error
            }
        } else {
            // Handle error
        }
        // Apple Maps
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = item.name
        mapItem.openInMaps(launchOptions: nil)
    }
}
