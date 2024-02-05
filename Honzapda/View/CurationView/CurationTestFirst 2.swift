//
//  CurationTestFirst.swift
//  Honzapda
//
//  Created by 이재용 on 1/31/24.
//

import Foundation
import SwiftUI


struct CurationTestFirst: View {
    var body: some View {
        ZStack{
            Image(uiImage: .init(systemName: "qorud")!) // 배경
                .resizable()
                .scaledToFit()
            Text("오늘의 기분은 \n어때요?")
               // .modifier(T)
            
        }
    }
}
