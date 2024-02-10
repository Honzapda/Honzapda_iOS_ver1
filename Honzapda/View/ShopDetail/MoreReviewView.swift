//
//  MoreReviewView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/25.
//

import Foundation
import SwiftUI

/*
struct MoreReviewView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
        NavigationView{
            GeometryReader{proxy in
                let safeArea=proxy.safeAreaInsets
                let minY=proxy.frame(in: .global).minY
                
                ZStack(alignment:.top){
                    ScrollView{
                        VStack{
                            reviewImageView(img)
                                .padding(.vertical, 40)
                            
                            Rectangle()
                                .frame(minWidth: proxy.size.width)
                                .foregroundStyle(CustomColors.gray01)
                            
                            reviewView()
                                .padding(.vertical, 40)
                        }
                        .offset(y: minY)
                    }
                    .frame(width: proxy.size.width)
                    
                    .navigationBarBackButtonHidden(true)
                    headerView()
                        .padding(.top, safeArea.top)
                        .offset(y:-minY)
                }
            }
        }
    }

    
    @ViewBuilder
    func headerView()->some View{
        VStack(alignment: .leading){
            HStack(){
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
                .padding(.trailing, 25)
                .padding(.leading)
                
                Text(shops[0].shopName)
                    .font(Font.custom("S-Core Dream", size: 14))
                    .foregroundStyle(.black)
                    .padding(.vertical, 12)
                
                Spacer(minLength: 0)
                
                Button{
                    
                } label: {
                    Image("icon_heart")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 18)
                        .padding(.trailing,24)
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            
            Spacer()
            
            Divider()
        }
        .background(CustomColors.white)
        .frame(height: 45)
        //.padding(.top, safeArea.top)
    }
    
    @ViewBuilder
    func reviewImageView(_ reviewImages: [ReviewImage])->some View{
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("사진 모아보기")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundStyle(CustomColors.gray09)
                
                Spacer()
                
                Button{
                    
                } label: {
                    Text("모든 사진 보기")
                        .font(Font.custom("S-Core Dream", size: 9))
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 4){
                    ForEach(reviewImages) { reviewImage in
                        reviewImage.reviewImage
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    func reviewView()->some View{
        VStack(alignment: .leading, spacing: 12){
            HStack{
                HStack(spacing: 0){
                    Text("리뷰 ")
                        .foregroundStyle(CustomColors.gray09)
                    Text(String(reviews.count))
                        .foregroundStyle(CustomColors.primary05)
                    Text("개")
                        .foregroundStyle(CustomColors.gray09)
                }
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                
                Spacer()
                
                NavigationLink{
                    ReviewWriteView()
                } label: {
                    Text("리뷰 작성하기")
                        .font(Font.custom("S-Core Dream", size: 9))
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            
            Text("유저들이 제공한 리뷰를 살펴보세요.\n유저들이 선택한 정보 순으로 제공해드릴게요 :)")
                .multilineTextAlignment(.leading)
                .font(Font.custom("S-Core Dream", size: 9))
                .foregroundStyle(CustomColors.gray06)
                .padding(.bottom, 12)
            
            ForEach(reviews){cell in
                reviewCell(cell)
                    .padding(.bottom, 4)
            }
             
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
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
    MoreReviewView()
}
*/
