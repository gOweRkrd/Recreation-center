import SwiftUI

enum StringResources {
    
    enum NetworkManager {
        static let invalidUrl = "Invalid URL"
        static let invalidResponse = "Invalid response"
        static let statusCode = "Unexpected status code:"
    }
    
    enum MainScreenView {
        static let title = "Категории"
        static let text = "Unknown name"
    }
    
    enum MainViewModel {
        static let networkError = "network Error"
        static let decodingError = "decoding Error"
    }
    
    enum DetailView {
        static let title = "Объекты"
    }
    
    enum DetailViewModel {
        static let alert = "Choose Map App"
        static let dgis = "2GIS"
        static let appleMap = "Apple Maps"
        static let googleMap = "Google Maps"
        static let cancel = "Cancel"
        static let errorPrint = "Error fetching data:"
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
    }
}

typealias R = StringResources
