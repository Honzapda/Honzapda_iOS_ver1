//
//  ReviewImage.swift
//  Honzapda
//
//  Created by 이재용 on 2/6/24.
//

//
//  ReviewImage.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/06.
//

import Foundation
import SwiftUI

struct ReviewImage: Codable{
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ImageDtoList
}

struct ImageDtoList: Codable {
    let imageDtoList: [Image_]?
    let getNumberOfElements: Int
    let hasNext: Bool
    let hasPrevious: Bool
}

/*
 {
     "isSuccess": true,
     "code": "COMMON200",
     "message": "성공입니다.",
     "result": {
         "imageDtoList": [
             {
                 "imageId": 28,
                 "url": "23"
             },
             {
                 "imageId": 27,
                 "url": "2"
             },
             {
                 "imageId": 26,
                 "url": "123"
             }
         ],
         "getNumberOfElements": 3, // 현재 조회 리스트 요소 갯수
           "hasNext": true, // 다음 페이지 여부
         "hasPrevious": false // 이전 페이지 여부
     }
 }
 */
