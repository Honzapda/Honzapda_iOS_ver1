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
    var rating: UInt
    var visitDate: Date?
    
    var reviewBody: String
    var reviewImage: [Image]
}
