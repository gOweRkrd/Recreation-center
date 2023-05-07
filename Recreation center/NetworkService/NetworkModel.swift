import Foundation

// MARK: - NewsModel
struct NetworkModel: Codable {
    let success: Bool
    let time: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let geo: Geo?
    let categories: [Category]?
    let objects: [Object]?
}

struct Category: Codable, Hashable {
    let name: String?
    let type: TypeEnum?
    let icon: Icon?
    let count: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

enum Icon: String, Codable {
    case rstBasketFill = "rst-basket-fill"
    case rstChildren = "rst-children"
    case rstFacesHappy = "rst-faces_happy"
    case rstFoodForkDrink = "rst-food-fork-drink"
    case rstMapMarker = "rst-map_marker"
    case rstStarsOutline = "rst-stars_outline"
    case rstSurprise = "rst-surprise"
}

enum TypeEnum: String, Codable {
    case child
    case food
    case fun
    case gift
    case infrastructure
    case place
    case shop
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lon: Double?
}

struct Object: Codable, Identifiable {
    let id: Int?
    let name, description: String?
    let image: URL?
    let type: TypeEnum?
    let icon: Icon?
    let lat, lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, image, type, icon, lat, lon
    }
}
