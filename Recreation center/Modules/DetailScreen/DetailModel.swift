import Foundation

struct Object: Codable, Identifiable {
    let id: Int?
    let name, description: String?
    let image: String?
    let type: TypeEnum?
    let icon: Icon?
    let lat, lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, image, type, icon, lat, lon
    }
}
