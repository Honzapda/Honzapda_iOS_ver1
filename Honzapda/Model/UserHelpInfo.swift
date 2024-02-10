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

struct UserHelpInfo: Identifiable{
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

let userHelpInfo1 = UserHelpInfo(profile: Image("profile_4"), name: "체리", day: "목", hour: 17, densityPer: 90, desk: "넓은", socket: "넉넉한", socketLocation: "책상 밑", restroom: "1층 계단 옆", music: "잔잔한", light: "밝은", mood: "아늑한")

let userHelpInfo2 = UserHelpInfo(profile: Image("profile_5"), name: "이제", day: "월", hour: 12, densityPer: 80, desk: "넓은", socket: "적당한", socketLocation: "책상 밑", restroom: "2층 계단 옆", music: "재즈", light: "적당한", mood: "잔잔한")

let userHelpInfos: [UserHelpInfo] = [userHelpInfo1, userHelpInfo2]

//var reviews: [Review] = [review1, review2, review3]
