import Foundation

public struct HTTPMethod: Hashable {
    public static let get = Self(rawValue: "GET")
    public static let post = Self(rawValue: "POST")
    public static let put = Self(rawValue: "PUT")
    public static let delete = Self(rawValue: "DELETE")

    public let rawValue: String
}
