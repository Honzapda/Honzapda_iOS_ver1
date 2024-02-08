//
//  Review.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//


import Foundation
import SwiftUI

struct Review: Identifiable{
    var id = UUID()

    var profile: Image
    var name: String
    var rating: Int
    var visitDate: String

    var reviewBody: String
    var reviewImage: [Image] = []
}

let review1 = Review(profile: Image("profile1"), name: "맥구", rating: 5, visitDate: "2024.02.17", reviewBody: "처음 가봤는데 사장님이 친절하시고 강아지가 귀엽고 인테리어가 예뻐요! 조용해서 친구랑 가서 이야기하기 좋습니다. 근데 가서 공부하기에는 테이블도 협소하고 분위기도 그런 분위기는 아닌 것 같아요. 담소 나누기 좋은 카페 ^^")

let review2 = Review(profile: Image("profile_2"), name: "젬마", rating: 3, visitDate: "2024.02.15", reviewBody: "카페가 좁아서 전체 회의는 어렵겠는데요 ... 아쉽습니다.", reviewImage: [Image("cafe_image"), Image("cafe_image"), Image("cafe_image"), Image("cafe_image")])

let review3 = Review(profile: Image("profile_3"), name: "웅이", rating: 4, visitDate: "2024.02.13", reviewBody: "서버 회의하기 딱 좋은 장소입니다.", reviewImage: [Image("cafe_image")])
