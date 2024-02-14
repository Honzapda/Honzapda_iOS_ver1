//
//  Review.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//


import Foundation
import SwiftUI

 struct Review: Codable {
     let isSuccess: Bool
     let code: String
     let message: String
     let result: ReviewResult
 }

 struct ReviewResult: Codable {
     let reviews: [ReviewBody]
     let listSize: Int
     let totalPage: Int
     let totalElements: Int
     let currentPage: Int
     let isFirst: Bool
     let isLast: Bool
 }

 struct ReviewBody: Codable, Identifiable {
     let user: User
     let score: Double
     let images: [Image_]?
     let body: String
     let visitedAt: String
     let reviewId: Int
     let shopId: Int
     let createdAt: String
     
     var id: Int {return reviewId}
 }
// 중복이라 userfeedbackapi의 유저로 대체합니다
//
// struct User: Codable {
//     let id: Int
//     let name: String
//     let profileImage: String
//     let email: String
//     let signUpType: String
// }

 struct Image_: Codable {
     let imageId: Int
     let url: String
 }
