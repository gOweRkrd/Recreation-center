import SwiftUI

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
    let color: Color?
    
    enum CodingKeys: String, CodingKey {
        case name, type, count
        case colorName = "color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        type = try container.decodeIfPresent(TypeEnum.self, forKey: .type)
        count = try container.decodeIfPresent(Int.self, forKey: .count)
        
        if let colorName = try container.decodeIfPresent(String.self, forKey: .colorName) {
            switch colorName {
            case "cyan-10":
                    color = Color(.sRGB, red: 0.0, green: 0.5765, blue: 0.6078)
            case "danger-10":
                    color = Color(red: 1.0, green: 0.2392, blue: 0.2)
            case "info-10":
                    color = Color(red: 0.0, green: 0.0, blue: 0.8)
            case "primary-10":
                    color = Color(red: 0.1019, green: 0.506, blue: 0.9803)
            case "success-10":
                    color = Color(red: 0.0667, green: 0.6549, blue: 0.4078)
            case "violet-10":
                    color = Color(red: 0.2706, green: 0.1529, blue: 0.6)
            case "warning-10":
                    color = Color(red: 0.9216, green: 0.549, blue: 0.0)
            default:
                    color = nil
            }
            
        } else {
            color = nil
        }
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
