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
