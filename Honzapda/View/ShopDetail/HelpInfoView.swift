

import Foundation
import SwiftUI


struct HelpInfoView: View {
    @ObservedObject var vm: ShopDetailViewModel
    @ObservedObject var helpInfoVm: UserHelpInfoViewModel
    
    var inputFormatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            // MARK: 설명
            HStack(){
                VStack(alignment: .leading, spacing: 12){
                    HStack{
                        Text("유저의 도움 정보")
                            .font(Font.custom("S-CoreDream-6Bold", size: 16))
                            .foregroundStyle(CustomColors.gray09)
                        NavigationLink{
                            HelpInfoWriteWrapperView(shopId: vm.shopDetail?.result.shopId, shopName: vm.shopDetail?.result.shopName)
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
                
                Spacer()
                
                NavigationLink{
                    UserFeedbackView(vm: helpInfoVm, shopId: vm.shopDetail?.result.shopId, shopName: vm.shopDetail?.result.shopName)
                } label: {
                    Text("정보 더 보기")
                        .font(Font.custom("S-CoreDream-5Medium", size: 9))
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            // MARK: Info Cells
            if let userHelpInfos = vm.shopDetail?.result.userHelpInfoDtoList {
                ForEach(userHelpInfos) {helpInfo in
                    userHelpInfoCell(helpInfo)
                }
            }
        }
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
    
    func getUrl(from urlString: String) -> URL? {
            guard let url = URL(string: urlString) else {
              return nil
            }
        return url
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
}

