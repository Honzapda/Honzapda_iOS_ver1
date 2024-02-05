//
//  ReviewTextFieldStyle.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/30.
//

import Foundation
import SwiftUI

struct ReviewTextFieldStyle: TextFieldStyle{
    
    func _body(configuration: TextField<Self._Label>) -> some View{
        
        ZStack{
            Rectangle()
                .frame(width: 345, height: 240)
                .foregroundStyle(CustomColors.gray02)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay{
                    Text("리뷰는 최소 40자 이상으로 작성해주세요!\n정확한 리뷰는 다른 유저에게 큰 도움이 돼요 :)")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundStyle(CustomColors.gray06)
                }
        }
    }
}
