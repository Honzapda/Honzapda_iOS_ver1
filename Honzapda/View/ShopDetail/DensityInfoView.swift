//
//  DensityInfoView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/22.
//

import Foundation
import SwiftUI

// MARK: temporary density inf/
let temp:[String: Int] = ["월":1, "화":3, "수":1, "목": 2, "금": 1, "토":3, "일":3 ]

struct DensityInfoView: View {
    let days:[String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: 요일별 혼잡도
            VStack(alignment: .leading) {
                HStack {
                    Text("요일별 혼잡도")
                        .font(Font.custom("S-CoreDream-6Bold", size: 16))
                        .foregroundStyle(CustomColors.gray09)
                    Button{
                        
                    } label: {
                        Image("icon_union")
                            .foregroundStyle(CustomColors.gray05)
                    }
                }
                .padding(.bottom, 8)
                
                Text(
                """
                요일별 혼잡도는 혼잡도 데이터를 모아 생성된 예상 혼잡도로서, 실제 척도와는 다를 수 있으니 유의하세요!
                """
                )
                .font(Font.custom("S-Core Dream", size: 9))
                .foregroundStyle(CustomColors.gray06)
                .padding(.bottom, 24)
                
                HStack{
                    ForEach(days, id: \.self){dayVar in
                        dayCell(dayVar)
                    }
                }
            }
            .padding(.bottom, 32)
            
            // MARK: 평균 혼잡도
            VStack(alignment: .leading){
                    Text("평균 혼잡도")
                        .font(Font.custom("S-CoreDream-6Bold", size: 16))
                        .foregroundStyle(CustomColors.gray09)
                
                Spacer(minLength: 8)
                
                    Text("평일과 주말 각각 어느 시간대에 가장 카페가 혼잡한지 알 수 있어요.")
                        .font(Font.custom("S-Core Dream", size: 9))
                        .foregroundStyle(CustomColors.gray06)
                
                Spacer(minLength: 24)
            }
            HStack{
                avgDensityCell(title: "평일", 18, 20)
                avgDensityCell(title: "주말", 14, 16)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 40)
    }
    
    @ViewBuilder
    func dayCell(_ dayVar: String)->some View{
        // MARK: dayVar값으로 각 이미지의 색 뿌려주기
        var src: String = "icon_cup_red"

        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 42,height: 61)
            .background(CustomColors.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .overlay{
                VStack{
                    Text(dayVar)
                        .font(Font.custom("S-Core Dream", size: 8))
                        .foregroundStyle(CustomColors.black)
                    Image(src)
                }
            }
    }
    
    @ViewBuilder
    func avgDensityCell(title text:String, _ from: Int, _ to: Int)->some View{
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 148, height: 115)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 4)
            .overlay{
                Spacer(minLength: 16)
                VStack(){
                    Text(text)
                        .font(Font.custom("S-CoreDream-6Bold", size: 14))
                        .padding(.vertical, 8)
                    HStack(spacing: 2){
                        Text("\(from)"+"시")
                            .font(Font.custom("S-CoreDream-6Bold", size: 18))
                            .foregroundStyle(CustomColors.primary05)
                        Text("부터")
                            .font(Font.custom("S-CoreDream-3Light", size: 12))
                            .foregroundStyle(CustomColors.gray06)
                    }
                    HStack(spacing: 2){
                        Text("\(to)"+"시")
                            .font(Font.custom("S-CoreDream-6Bold", size: 18))
                            .foregroundStyle(CustomColors.primary05)
                        Text("까지")
                            .font(Font.custom("S-CoreDream-3Light", size: 12))
                            .foregroundStyle(CustomColors.gray06)
                    }
                    .padding(.bottom, 16)
                }
            }
    }
}

#Preview {
    ShopDetailView()
}
