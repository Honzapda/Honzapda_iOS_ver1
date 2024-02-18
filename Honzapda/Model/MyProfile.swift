import Foundation
import SwiftUI

struct MyProfileResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: MyProfileResult
}

struct MyProfileResult: Codable {
    let id: Int
    let name: String
    let profileImage: String
    let preferNameList: [String]
    let likeShops: [LikeShop]
}

struct LikeShop: Codable {
    let shopId: Int
    let shopName: String
    let shopMainImage: String
}

