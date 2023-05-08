import Foundation

// MARK: - NetworkModel
struct NetworkModel: Decodable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let geo: Geo?
    let categories: [Category]?
    let objects: [Object]?
}

// MARK: - Category
struct Category: Decodable, Hashable {
    let name: String?
    let type: TypeEnum?
    let count: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

// MARK: - Geo
struct Geo: Decodable {
    let lat, lon: Double?
}

// MARK: - Object
struct Object: Decodable, Identifiable {
    let id: Int?
    let name, description: String?
    let image: URL?
    let type: TypeEnum?
    let lat, lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, image, type, lat, lon
    }
}

enum TypeEnum: String, Decodable {
    case child
    case food
    case fun
    case gift
    case infrastructure
    case place
    case shop
}
