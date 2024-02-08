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

struct ReviewImage: Identifiable{
    var id = UUID()

    var reviewImage: Image
}

let img: [ReviewImage] = [ReviewImage(reviewImage: Image("cafe_image")), ReviewImage(reviewImage: Image("cafe_image")), ReviewImage(reviewImage: Image("cafe_image")), ReviewImage(reviewImage: Image("cafe_image")),ReviewImage(reviewImage: Image("cafe_image")),ReviewImage(reviewImage: Image("cafe_image")),ReviewImage(reviewImage: Image("cafe_image"))]
