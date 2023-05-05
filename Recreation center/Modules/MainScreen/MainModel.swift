import Foundation

struct Category: Codable, Hashable {
    let name: String?
    let type: TypeEnum?
    let icon: Icon?
    let count: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
