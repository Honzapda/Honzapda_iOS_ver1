//
//  HelpInfoView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/22.
//

import Foundation
import SwiftUI

struct HelpInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            // MARK: 설명
            HStack(spacing: 70){
                VStack(alignment: .leading, spacing: 12){
                    HStack{
                        Text("유저의 도움 정보")
                            .font(Font.custom("S-CoreDream-6Bold", size: 16))
                            .foregroundStyle(CustomColors.gray09)
                        Button{
                            
                        } label: {
                            Text("정보 제공하기")
                                .font(Font.custom("S-CoreDream-5Medium", size: 9))
                                .foregroundStyle(CustomColors.primary05)
                        }
                    }
                    Text("혼잡다 유저들이 직접 제공하는 카페 정보를 살펴보세요.")
                        .font(Font.custom("S-CoreDream-5Medium", size: 9))
                        .foregroundStyle(CustomColors.gray06)
                }
                
                Button{
                    
                } label: {
                    Text("정보 더 보기")
                        .font(Font.custom("S-CoreDream-5Medium", size: 9))
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            // MARK: Info Cells
            userHelpInfoCell()
            userHelpInfoCell()
        }
    }
    
    @ViewBuilder
    func userHelpInfoCell()->some View{
        let dummy = UserHelpInfo(profile: Image("logo"), name: "체리", day: "목", hour: 17, densityPer: 90, desk: "넓은", socket: "넉넉한", socketLocation: "책상 밑", restroom: "1층 계단 옆", music: "잔잔한", light: "밝은", mood: "아늑한")
        
        let profile = dummy.profile
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
        let name = Text(dummy.name)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundStyle(CustomColors.gray09)
        let day = Text(dummy.day)
            .font(Font.custom("S-CoreDream-5Medium", size: 8))
            .foregroundStyle(CustomColors.primary05)
        let hour = Text("\(dummy.hour)"+"시")
            .font(Font.custom("S-CoreDream-5Medium", size: 8))
            .foregroundStyle(CustomColors.primary05)
        let densityPer = Text("\(dummy.densityPer)"+"%")
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
            .foregroundColor(CustomColors.primary05)
        let desk = Text(dummy.desk)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        let socket = Text(dummy.socket)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        let socketLocation = Text(dummy.socketLocation)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        let restroom = Text(dummy.restroom)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        let music = Text(dummy.music)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        let light = Text(dummy.light)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        let mood = Text(dummy.mood)
            .padding(.horizontal, 10)
            .font(Font.custom("S-CoreDream-6Bold", size: 12))
            .foregroundColor(CustomColors.primary05)
            .overlay{
                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
            }
        
        VStack(alignment: .leading){
            HStack(alignment: .center, spacing: 12){
                profile
                VStack(alignment: .leading, spacing: 2){
                    name
                    HStack(spacing: 0){
                        Text("이 카페를 ")
                            .font(Font.custom("S-CoreDream-3Light", size: 8))
                            .foregroundStyle(CustomColors.gray07)
                        day
                        Text("요일 ") 
                            .font(Font.custom("S-CoreDream-5Medium", size: 8))
                            .foregroundStyle(CustomColors.primary05)
                        hour
                        Text("에 방문했어요")
                            .font(Font.custom("S-CoreDream-3Light", size: 8))
                            .foregroundStyle(CustomColors.gray07)
                    }
                }
            }
            .padding(.leading, 24)
            
            VStack(alignment: .leading, spacing: 12){
                HStack(spacing: 0){
                    Text("혼잡도는")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                    densityPer
                    Text("정도인 것 같아요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
                HStack(spacing: 0){
                    desk
                    Text("책상을 보유하고 있어요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
                HStack(spacing: 0){
                    socket
                    Text("콘센트를 보유하고 있고 주로")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                    socketLocation
                    Text("에 있어요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
                HStack(spacing: 0){
                    Text("화장실은")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                    restroom
                    Text("에 있어요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
                HStack(spacing: 0){
                    Text("노래는")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                    music
                    Text("음악이 많이 나와요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
                HStack(spacing: 0){
                    Text("조명은")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                    light
                    Text("편이에요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
                HStack(spacing: 0){
                    Text("전체적인 분위기는")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                    mood
                    Text("것 같아요")
                        .font(Font.custom("S-CoreDream-5Medium", size: 10))
                        .foregroundStyle(CustomColors.black)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
        }
        .frame(width: 345)
        .padding(.vertical, 24)
        .background(CustomColors.gray02)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    HelpInfoView()
}