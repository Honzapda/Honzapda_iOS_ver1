import Foundation
import SwiftUI

struct SearchResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SearchResult
}

struct SearchResult: Codable {
    let content: [SearchShop]
    let pageable: SearchPageable
    let total: Int
    let numberOfElements: Int
    let size: Int
    let number: Int
    let sort: [String] // 수정
    let first: Bool
    let last: Bool
    let empty: Bool
}

struct SearchShop: Codable, Identifiable {
    var shopId: Int
    var shopName: String
    var address: String
    var address_spec: String
    var openNow: Bool
    var photoUrl: String
    
    var id: Int {
           return shopId
       }
}

struct SearchPageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [String]
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}
