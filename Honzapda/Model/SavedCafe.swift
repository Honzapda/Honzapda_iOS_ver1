import Foundation

struct SavedCafeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SavedCafeResult
}

struct SavedCafeResult: Codable {
    let content: [SavedCafeList]
    let pageable: SavedCafePageable
    let first: Bool
    let last: Bool
    let size: Int
    let number: Int
    let sort: [String]
    let numberOfElements: Int
    let empty: Bool
}

struct SavedCafeList: Codable {
    let shopId: Int
    let shopName: String
    let address: String
    let address_spec: String
    let openNow: Bool
    let mainImage: String?
    let bookMarkCount: Int
    let reviewCount: Int
    let distance: Double
}

struct SavedCafePageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [String]
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}
