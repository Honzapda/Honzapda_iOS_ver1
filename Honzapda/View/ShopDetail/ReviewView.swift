//
//  ReviewView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/22.
//

import Foundation
import SwiftUI

struct ReviewView: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack(alignment:.center, spacing: 110){
                    VStack(alignment: .leading, spacing: 8){
                        HStack{
                            Text("리뷰")
                                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                            Button{
                                
                            }label: {
                                Text("리뷰 작성하기")
                                    .font(Font.custom("S-CoreDream-5Medium", size: 9))
                                    .foregroundStyle(CustomColors.primary05)
                            }
                        }
                        Text("다른 혼잡다 유저들이 남긴 리뷰를 살펴보세요.")
                            .font(Font.custom("S-Core Dream", size: 9))
                            .foregroundStyle(CustomColors.gray06)
                    }
                    //.padding(.bottom, 16)
                    
                    Button{
                        
                    }label: {
                        Text("리뷰 더 보기")
                            .font(Font.custom("S-CoreDream-5Medium", size: 9))
                            .foregroundStyle(CustomColors.primary05)
                    }
                    .padding(.vertical, 16)
                }
            }
            .padding(.bottom, 16)
            
            VStack(spacing: 16){
                reviewCell()
                reviewCell()
                reviewCell()
            }
        }
    }
    
    @ViewBuilder
    func reviewCell()->some View{
        let dummy = Review(profile:Image("logo"), name: "aa", rating: 4, reviewBody:
                            "가나다라마바사아자\n차카타파하", reviewImage: [Image("logo"), Image("logo"), Image("logo"), Image("logo")])
        
        VStack(spacing: 16){
            HStack(spacing: 170){
                HStack(spacing: 12){
                    dummy.profile
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text(dummy.name)
                            .font(Font.custom("S-CoreDream-6Bold", size: 12))
                        Text("별점 \(dummy.rating) 점")
                            .font(Font.custom("S-Core Dream", size: 8))
                            .foregroundStyle(CustomColors.primary04)
                    }
                }
                Button{
                    
                }label: {
                    Text("리뷰 신고하기")
                        .font(Font.custom("S-Core Dream", size: 7))
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(CustomColors.gray06)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0..<dummy.reviewImage.count){i in
                        dummy.reviewImage[i]
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 16){
                Text(dummy.reviewBody)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("S-Core Dream", size: 9))
                    .foregroundStyle(CustomColors.black)
                
                Text("날짜 에 방문")
                    .font(Font.custom("S-Core Dream", size: 8))
                    .foregroundStyle(CustomColors.gray07)
            }
            .frame(width: 297, alignment: .leading)
            .padding(.horizontal, 24)
        }
        .frame(width: 345)
        .padding(.vertical, 24)
        .background(CustomColors.gray02)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
   ShopDetailView()
}
