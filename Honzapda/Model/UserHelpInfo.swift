//
//  UserHelpInfo.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/24.
//

import Foundation
import SwiftUI

struct UserHelpInfo{
    var id=UUID()
    
    var profile: Image
    var name: String
    
    var day: String
    var hour: Int
    
    var densityPer: Int
    var desk: String
    var socket: String
    var socketLocation: String
    var restroom: String
    var music: String
    var light: String
    var mood: String
}
