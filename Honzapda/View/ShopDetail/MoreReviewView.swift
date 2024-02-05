//
//  MoreReviewView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/25.
//

import Foundation
import SwiftUI

struct MoreReviewView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
        NavigationStack{
            GeometryReader{proxy in
                let safeArea=proxy.safeAreaInsets
                let minY=proxy.frame(in: .global).minY
                
                ZStack(alignment:.top){
                    ScrollView{
                        VStack{
                            Text("Helo WOrld")
                            NavigationLink{
                                ReviewWriteView()
                            } label: {
                                Text("Button")
                            }
                            .offset(y: minY)
                        }
                    }
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
    func reviewCell()->some View{
        
        let dummy = Review(profile:Image("logo"), name: "가나다", rating: 4, visitDate: "2024.02.05", reviewBody:
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
                        Text("별점 \(dummy.rating)점")
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
                
                Text(dummy.visitDate + " 방문")
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
