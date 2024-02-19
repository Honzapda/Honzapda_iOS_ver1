//
//  UserHelpInfo.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/24.

//
//  UserHelpInfo.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/24.
//


import Foundation
import SwiftUI

struct UserHelpInfo: Codable, Identifiable {
    let user: User
    
    let visitDateTime: String
    let like: Like
    
    let congestion: String
    let deskSize, outletCount, light, outletLocation: String?
    let restroomLocation, musicGenre, atmosphere: String?
    let userHelpInfId: Int
    let createdAt: String
    
    var id: Int { return userHelpInfId }
}

struct User: Codable {
    let id: Int
    let name: String
    let profileImage: String?
    let email: String?
    let signUpType: String?
}

// Define your models to parse the JSON response
struct APIResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ResultData
}

struct ResultData: Codable {
    let userHelpInfoDtoList: [UserHelpInfo]
    let listSize: Int
    let totalPage: Int
    let currentPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct Like: Codable {
    let likeCount: Int
    let userLike: Bool
}
