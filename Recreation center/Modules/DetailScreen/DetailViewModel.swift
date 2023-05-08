import CoreLocation
import MapKit
import SwiftUI

final class DetailViewModel: ObservableObject {
    @Published var detailModel = [Object]()
    @Published  var images: [URL: UIImage] = [:]
    
    private let networkService: NetworkServiceType & DetailNetworkServiceType
    
    init(networkService: NetworkServiceType & DetailNetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchDetail(category: Category?) {
        Task {
            do {
                let objects = try await networkService.fetchDetail(category: category)
                DispatchQueue.main.async {
                    self.detailModel = objects
                }
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
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
