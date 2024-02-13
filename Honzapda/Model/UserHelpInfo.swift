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

/*
struct UserHelpInfo: Codable{
    var user: User
    var visitDateTime: String
    var like: Like
    var congestion: String
    var deskSize: String
    var outletCount: String
    var light: String
    var outletLocation: String
    var restroomLocation: String
    var musicGenre: String
    var atmosphere: String
    var userHelpInfId: Int
    var createdAt: String
    
    enum CodingKeys: String, CodingKey{
        case user, visitDateTime, like, congestion, deskSize, outletCount, light, outletLocatoin, restroomLocation, musicGenre, atmosphere, userHlepInfId, createdAt
    }
}
*/

struct Like: Codable{
    var likeCount: Int
    var userLike: Bool
}
