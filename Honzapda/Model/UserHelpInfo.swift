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
