//
//  ReviewView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/22.
//

import Foundation
import SwiftUI

/*
struct ReviewView: View {
    var body: some View {
            VStack{
                VStack(alignment: .leading){
                    HStack(alignment:.center, spacing: 110){
                        VStack(alignment: .leading, spacing: 8){
                            HStack{
                                Text("리뷰")
                                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                                    .foregroundStyle(CustomColors.gray09)
                                NavigationLink{
                                    ReviewWriteView()
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
                        
                        NavigationLink{
                            MoreReviewView()
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
                    ForEach(reviews){cell in
                        reviewCell(cell)
                            .padding(.bottom, 4)
                    }
                }
            }
        
    }
    
    @ViewBuilder
    func reviewCell(_ review: Review)->some View{
       
        VStack(spacing: 16){
            HStack(spacing: 170){
                HStack(spacing: 12){
                    review.profile
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text(review.name)
                            .font(Font.custom("S-CoreDream-6Bold", size: 12))
                            .foregroundStyle(CustomColors.gray09)
                        Text("별점 \(review.rating)점")
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
                    ForEach(0..<review.reviewImage.count){i in
                        review.reviewImage[i]
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 16){
                Text(review.reviewBody)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("S-Core Dream", size: 9))
                    .foregroundStyle(CustomColors.black)
                
                Text(review.visitDate + " 방문")
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
*/
