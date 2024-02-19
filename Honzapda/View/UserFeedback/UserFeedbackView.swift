//
//  UserFeedbackView.swift
//  Honzapda
//
//  Created by 이재용 on 2/11/24.
//
// how to work
/*
 1. 구조
 [네비바]
 [고정 뷰, 유저 도움 정보 (var totalElement) 개 , 정보제공하기 버튼, 설명]
 [스크롤 뷰 of (userFeedbackCellView), CreateUFCellView()함수로 생성 ] - 무한스크롤
 2. 동작
 - 화면 진입
    UFBGetapi 작동,  ?? 그러면 shopid는 어떻게 알것인가?
 - 해당 api에서 받아온 값으로 (var totalElement)를 채움
 - createUFCellView로 UFBcellView 생성, 페이지만큼 생성
 - 해당 셀을 Vstack, 스크롤 뷰 내에 생성, 
 */
import Foundation
import SwiftUI

struct UserFeedbackView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vm: UserHelpInfoViewModel
    
    var shopId: Int?
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
                            helpInfoView()
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
        .navigationBarBackButtonHidden()
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
    
    
    // MARK: 추후에 cell 변경하실 때 이 함수만 수정하시면 됩니다 (142줄)
    @ViewBuilder
    func helpInfoView()->some View{
        VStack(alignment: .leading, spacing: 12){
            HStack{
                HStack(spacing: 0){
                    Text("유저의 도움 정보 ")
                        .foregroundStyle(CustomColors.gray09)
                    Text(String(vm.apiResponse?.result.userHelpInfoDtoList.count ?? 0))
                        .foregroundStyle(CustomColors.primary05)
                    Text("개")
                        .foregroundStyle(CustomColors.gray09)
                }
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                
                Spacer()
                
                NavigationLink{
                    HelpInfoWriteWrapperView(shopId: shopId ?? 0, shopName: shopName ?? "")
                } label: {
                    Text("정보 제공하기")
                        .font(Font.custom("S-Core Dream", size: 9))
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            
            Text("유저들이 도와 제공한 카페 정보를 살펴보세요.\n유저들이 선택한 정보 순으로 제공해드릴게요 :)")
                .multilineTextAlignment(.leading)
                .font(Font.custom("S-Core Dream", size: 9))
                .foregroundStyle(CustomColors.gray06)
                .padding(.bottom, 12)
            
            ForEach(vm.apiResponse?.result.userHelpInfoDtoList ?? []){cell in
                    // MARK: 여기 userHelpInfoCell만 UserFeedbackCell로 변경해주세요
                    userHelpInfoCell(cell)
                        .padding(.bottom, 4)
                }
             
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
    
    @ViewBuilder
    func userHelpInfoCell(_ helpInfo: UserHelpInfo)->some View{

        let  name = Text(helpInfo.user.name)
                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                .foregroundStyle(CustomColors.gray09)
        let day = Text(convertDateTimeToDayHourFormat(dateTimeString: helpInfo.visitDateTime) ?? "")
            .font(Font.custom("S-CoreDream-5Medium", size: 8))
            .foregroundStyle(CustomColors.primary05)
        
        VStack(alignment: .leading){
            HStack(alignment: .center, spacing: 12){
                AsyncImage(url: getUrl(from: helpInfo.user.profileImage!)) { image in
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                VStack(alignment: .leading, spacing: 2){
                    name
                    HStack(spacing: 0){
                        Text("이 카페를 ")
                            .font(Font.custom("S-CoreDream-3Light", size: 8))
                            .foregroundStyle(CustomColors.gray07)
                        day
                        Text("에 방문했어요")
                            .font(Font.custom("S-CoreDream-3Light", size: 8))
                            .foregroundStyle(CustomColors.gray07)
                    }
                }
            }
            .padding(.leading, 24)
            
            VStack(alignment: .leading, spacing: 0){
                HStack(spacing: 0){
                        Text("혼잡도는")
                            .font(Font.custom("S-CoreDream-5Medium", size: 10))
                            .foregroundStyle(CustomColors.black)
                    Text(helpInfo.congestion)
                            .padding(.horizontal, 10)
                            .font(Font.custom("S-CoreDream-6Bold", size: 12))
                            .overlay{
                                VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                            }
                            .foregroundColor(CustomColors.primary05)
                        
                        Text("정도인 것 같아요")
                            .font(Font.custom("S-CoreDream-5Medium", size: 10))
                            .foregroundStyle(CustomColors.black)
                }
                .padding(.vertical, 8)
                    if let desk = helpInfo.deskSize {
                        if desk != "none" {
                            HStack(spacing: 0){
                            Text(desk)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            
                            Text("책상을 보유하고 있어요")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                        }
                            .padding(.vertical, 8)
                    }
                }
                    if let socket = helpInfo.outletCount, let socketLocation = helpInfo.outletLocation {
                        if socket != "none" && socketLocation != "none" {
                            HStack(spacing: 0){
                            Text(socket)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            
                            Text("콘센트를 보유하고 있고 주로")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                            Text(socketLocation)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            
                            Text("에 있어요")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                        }
                            .padding(.vertical, 8)
                    }
                }
                    if let restroom = helpInfo.restroomLocation {
                        if restroom != "none" {
                            HStack(spacing: 0){
                            Text("화장실은")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                            Text(restroom)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            Text("에 있어요")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                        }
                            .padding(.vertical, 8)
                    }
                }
                    if let music = helpInfo.musicGenre {
                        if music != "none" {
                            HStack(spacing: 0){
                            Text("노래는")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                            Text(music)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            Text("음악이 많이 나와요")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                        }
                            .padding(.vertical, 8)
                    }
                }
                    if let light = helpInfo.light {
                        if light != "none" {
                            HStack(spacing: 0){
                            Text("조명은")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                            Text(light)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            Text("편이에요")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                        }
                            .padding(.vertical, 8)
                    }
                }
                if let mood = helpInfo.atmosphere {
                    if mood != "none" {
                        HStack(spacing: 0){
                            Text("전체적인 분위기는")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                            Text(mood)
                                .padding(.horizontal, 10)
                                .font(Font.custom("S-CoreDream-6Bold", size: 12))
                                .foregroundColor(CustomColors.primary05)
                                .overlay{
                                    VStack{Divider().offset(y:10).foregroundStyle(CustomColors.gray03)}
                                }
                            Text("것 같아요")
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundStyle(CustomColors.black)
                        }
                        .padding(.vertical, 8)
                    }
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
        outputFormatter.dateFormat = "EE요일 HH시"
        outputFormatter.locale = Locale(identifier: "ko_KR") // 한국어 요일 이름으로 설정
        outputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        // 변환된 문자열 반환
        return outputFormatter.string(from: date)
    }
    
    func getUrl(from urlString: String) -> URL? {
            guard let url = URL(string: urlString) else {
              return nil
            }
        return url

    }

    
}
