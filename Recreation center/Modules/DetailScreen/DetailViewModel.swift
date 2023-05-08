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
                print("\(R.DetailViewModel.errorPrint) \(error.localizedDescription)")
            }
        }
    }
    
    func loadImage(for item: Object) async {
        guard let imageUrl = item.image else { return }
        guard images[imageUrl] == nil else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            DispatchQueue.main.async {
                self.images[imageUrl] = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func openInMaps(item: Object) {
        guard let latitude = item.lat, let longitude = item.lon else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        guard let dgisURL = URL(string: "dgis://2gis.ru/routeSearch/rsType/car/to/\(coordinate.longitude),\(coordinate.latitude)"),
              let appleMapsURL = URL(string: "http://maps.apple.com/maps?daddr=\(coordinate.latitude),\(coordinate.longitude)"),
              let googleMapsURL = URL(string: "comgooglemaps://?daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving") else {
            return
        }
        
        let alertController = UIAlertController(
            title: nil,
            message: R.DetailViewModel.alert,
            preferredStyle: .actionSheet
        )
        
        if UIApplication.shared.canOpenURL(dgisURL) {
            let dgisAction = UIAlertAction(title: R.DetailViewModel.dgis, style: .default) { _ in
                UIApplication.shared.open(dgisURL, options: [:], completionHandler: nil)
            }
            alertController.addAction(dgisAction)
        }
        
        if UIApplication.shared.canOpenURL(appleMapsURL) {
            let appleMapsAction = UIAlertAction(title: R.DetailViewModel.appleMap, style: .default) { _ in
                UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
            }
            alertController.addAction(appleMapsAction)
        }
        
        if UIApplication.shared.canOpenURL(googleMapsURL) {
            let googleMapsAction = UIAlertAction(title: R.DetailViewModel.googleMap, style: .default) { _ in
                UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
            }
            alertController.addAction(googleMapsAction)
        }
        
        let cancelAction = UIAlertAction(title: R.DetailViewModel.cancel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        rootViewController.present(alertController, animated: true, completion: nil)
        
    }
}
