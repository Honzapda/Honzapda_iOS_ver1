//
//  Density.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/24.
//

import Foundation

struct DensityInfo{
    enum Density: Int {
        case high
        case medium
        case low
    }
    
    var id=UUID()
    
    var mon: Density
    var tue: Density
    var wed: Density
    var thu: Density
    var fri: Density
    var sat: Density
    var sun: Density
    
    var avgWeekdayDensity:[Int]
    var avgWeekendDensity:[Int]
}
