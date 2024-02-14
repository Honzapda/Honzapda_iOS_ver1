//
//  UserFeedbackCellView.swift
//  Honzapda
//
//  Created by 이재용 on 2/11/24.
//
/*
 스트럭트에 소유해야 하는 것 -> api에서 받아온 데이터 전부
 뷰에 그려지는 것
 "congestion": "20%",
                 "deskSize": "좁은",
                 "outletCount": "넉넉한",
                 "light": "밝은",
                 "outletLocation": "outletLocation_4dd5384a951c",
                 "restroomLocation": "restroomLocation_0e53be6b3fd7",
                 "musicGenre": "musicGenre_9024b8c589f1",
                 "atmosphere": "atmosphere_bdb0b8859ac4",
                 "userHelpInfId": 1,
                 "createdAt": "2024-02-09T20:18:24.132666"
 */
import Foundation
import SwiftUI

struct UserFeedbackCellView : View {
    let dataset : UserHelpInfo
    var body: some View {
        ZStack{
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 345, height: 297)
            .background(Color(red: 0.96, green: 0.96, blue: 0.95))
            .cornerRadius(12)
            VStack(alignment: .leading, spacing: 10){// 최외곽 브이스택
                HStack{ // user info, profile ---
              
                    AsyncImage(url: URL(string: dataset.user.profileImage!)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable() // 이미지의 크기를 조절할 수 있게 함
                                .scaledToFill() // 이미지를 프레임에 맞게 채움
                                .frame(width: 40, height: 40) // 이미지 뷰의 크기를 설정
                                .clipShape(Circle()) // 이미지를 원형으로 잘라냄
                                .overlay(Circle().stroke(CustomColors.primary05, lineWidth: 1))
                        case .failure(_):
                            Image(systemName: "person.fill") // 로딩 실패 시 대체 이미지
                                .font(.largeTitle)
                                .frame(width: 40, height: 40)
                                .background(Color.gray)
                                .clipShape(Circle())
                        case .empty:
                            ProgressView() // 이미지가 로딩 중일 때 표시될 내용
                        @unknown default:
                            EmptyView() // 예상치 못한 케이스 처리
                        }
                    }
                    
                   
                    VStack (alignment:.leading){
                        Text(dataset.user.name)
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        Text(dataset.visitDateTime)
                            .font(Font.custom("S-Core Dream", size: 8))
                            .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            print("like tap")
                        }, label: {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 17, height: 17)
                                .foregroundColor(CustomColors.primary05)
                        })
                        .padding(.bottom, 3)
                        
                        HStack{
                            Text("추천")
                                .font(Font.custom("S-Core Dream", size: 7))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
                            Text(String(dataset.like.likeCount))
                                .font(Font.custom("S-Core Dream", size: 7))
                                .multilineTextAlignment(.center)
                                .foregroundColor(CustomColors.primary05)
                                .padding(.horizontal, -5)
                            Text("개")
                                    .font(Font.custom("S-Core Dream", size: 7))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
                                    .padding(.leading,-5)
                        }
                    }
                }
                .frame(width: 345-48)
                
                .padding(.bottom, 20)
                
                HStack{
                    Text("혼잡도는 ")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                    VStack{
                        Text(dataset.congestion) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("정도인 것 같아요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
                HStack{
                    
                    VStack{
                        Text(dataset.deskSize!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("책상을 보유하고 있어요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
                HStack{
                    
                    VStack{
                        Text(dataset.outletCount!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("콘센트를 보유하고 있고 주로 ")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                    VStack{
                        Text(dataset.outletLocation!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                    Text("에 있어요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
                HStack{
                    Text("화장실은 ")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                    VStack{
                        Text(dataset.restroomLocation!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("에 있어요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
                HStack{
                    Text("노래는 ")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                    VStack{
                        Text(dataset.musicGenre!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("음악이 많이 나와요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
                HStack{
                    Text("조명은 ")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                    VStack{
                        Text(dataset.light!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("밝은 편이에요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
                HStack{
                    Text("전체적인 분위기는 ")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                    VStack{
                        Text(dataset.atmosphere!) //밑줄추가 필요
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                            .padding(.bottom,-7)
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 38, height: 1)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                    }
                   
                    Text("것 같아요")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(.black)
                }
            }
        }
        
    }
}


struct UserFeedbackCell_prev : PreviewProvider{
 
    static var previews: some View {
        UserFeedbackCellView(dataset: testuserinfo)
    }
}
let testuserinfo = UserHelpInfo(
       user: User(
           id: 4,
           name: "기승민",
           profileImage: "https://storage.googleapis.com/honzapda-bucket/image_my_profile.png",
           email: "ksm011212@gmail.com",
           signUpType: "LOCAL"
       ),
       visitDateTime: "2024-01-29T01:33:00",
       like: Like(
           likeCount: 0,
           userLike: false
       ),
       congestion: "30%",
       deskSize: "넓은",
       outletCount: "넉넉한",
       light: "밝은",
       outletLocation: "책상 밑",
       restroomLocation: "카운터 옆",
       musicGenre: "잔잔한",
       atmosphere: "아늑한",
       userHelpInfId: 1,
       createdAt: "2024-02-10T16:59:55.171192"
   )
