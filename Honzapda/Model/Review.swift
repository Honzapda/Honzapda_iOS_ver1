//
//  Review.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//


import Foundation
import SwiftUI

struct Review: Codable{
    let results: [ReviewResult]
}

struct Pagination: Codable {
    let listSize: Int
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct ReviewResult: Codable, Identifiable{
    let id = UUID()
    
    let img: [Images]
    let reviewId: Int
    let userId: Int
    let score: Int
    let body: String
    let visitedAt: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case img
        case reviewId
        case userId
        case score
        case body
        case visitedAt
        case createdAt
    }
}

struct Images: Codable{
    let imageId: Int
    let url: String
}
