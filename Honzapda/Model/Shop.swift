//
//  Shop.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//

import Foundation

struct Shop: Identifiable{
    var id = UUID()
    var shopID: Int64?
    var shopName: String
    var admiName: String?
    var description: String
    var otherDetails: String?
    var shopPhoneNumber: String
    var adminPhoneNumber: String?
    var rating: Double
    var adress: String
    var adressSpec: String
    var businessNumber: String?
    var inactiveDate: Date?
    // MARK: 구현 필요
    var reviewList: [Review]?
    var photoUrls: [String]
    var openNow: Bool
}


var shops: [Shop] = [
    Shop(shopName: "스테이 어도러블", description:
        """
        인테리어가 귀엽고 강아지가 감성적이예요
        """, shopPhoneNumber: "010-9999-9999", rating: 4.68, adress: "경기 용인시 기흥구", adressSpec: "죽전로43길 15-3 1층",  photoUrls: ["cafe_image"], openNow: true )
]

// MARK: wheres daily density?
