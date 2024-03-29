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
    
    @ObservedObject var vm: ReviewViewModel
    
    var shopId: Int
    var shopName: String?
    var inputFormatter = DateFormatter()
    
    var body: some View{
        NavigationView{
            GeometryReader{proxy in
                let safeArea=proxy.safeAreaInsets
                let minY=proxy.frame(in: .global).minY
                
                ZStack(alignment:.top){
                    ScrollView{
                        VStack{
                            if let res = vm.reviewWithImage.reviewImage?.result.imageDtoList {
                                reviewImageView(res)
                                    .zIndex(0)
                                    .padding(.vertical, 40)
                            }
                            else {
                                Text("WRONG!!!!")
                            }
                            
                            Rectangle()
                                .frame(minWidth: proxy.size.width)
                                .foregroundStyle(CustomColors.gray01)
                            
                            reviewView()
                                .zIndex(1)
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
            .onAppear {
                vm.doBoth(shopId: shopId)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func convertDateTimeToDayHourFormat(dateTimeString: String) -> String? {
        
        self.inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.inputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        // 문자열을 Date 객체로 변환
        guard let date = inputFormatter.date(from: dateTimeString) else {
            print("날짜 변환 실패")
            return nil
        }
        
        // 요일과 시간 정보를 포함하는 문자열로 포맷
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd 방문"
        outputFormatter.locale = Locale(identifier: "ko_KR") // 한국어 요일 이름으로 설정
        outputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        // 변환된 문자열 반환
        return outputFormatter.string(from: date)
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
                 
                // MARK: 가게 이름
                Text(shopName ?? "")
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
    }
    
    @ViewBuilder
    func reviewImageView(_ reviewImages: [Image_])->some View{
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
                        AsyncImage(url: getUrl(from: reviewImage.url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                ProgressView()
                            }
                     
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
                    Text(String(vm.reviewWithImage.review?.result.totalElements ?? 0))
                        .foregroundStyle(CustomColors.primary05)
                    Text("개")
                        .foregroundStyle(CustomColors.gray09)
                }
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                
                Spacer()
                
                NavigationLink{
                    ReviewWriteView(shopId: shopId, shopName: shopName ?? "")
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
            
            if let review = vm.reviewWithImage.review?.result.reviews {
                ForEach(review){cell in
                    reviewCell(cell)
                        .padding(.bottom, 4)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
    
    @ViewBuilder
    func reviewCell(_ review: ReviewBody)->some View{
       
        VStack(spacing: 16){
            HStack(spacing: 170){
                HStack(spacing: 12){
                    AsyncImage(url: getUrl(from: review.user.profileImage!)) { image in
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                    VStack(alignment: .leading){
                        Text(review.user.name)
                            .font(Font.custom("S-CoreDream-6Bold", size: 12))
                            .foregroundStyle(CustomColors.gray09)
                        Text("별점" + String(format: "%.0f", review.score) + "점")
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
                    ForEach(0..<(review.images?.count ?? 0) ){i in
                        if let img = review.images?[i].url{
                            AsyncImage(url: getUrl(from: img)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                ProgressView()
                            }
                        } else {}
                    }
                }
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 16){
                Text(review.body)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("S-Core Dream", size: 9))
                    .foregroundStyle(CustomColors.black)
                
                Text(convertDateTimeToDayHourFormat(dateTimeString: review.visitedAt) ?? "")
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
    
    func getUrl(from urlString: String) -> URL? {
            guard let url = URL(string: urlString) else {
              return nil
            }
        return url

    }
}
