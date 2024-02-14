//
//  HelpInfoWriteView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/08.
//

//struct UserHelpInfo: Codable, Identifiable {
//    let user: User
//    let visitDateTime: String
//    let like: Like
//    let congestion: String
//    let deskSize, outletCount, light, outletLocation: String?
//    let restroomLocation, musicGenre, atmosphere: String?
//    let userHelpInfId: Int
//    let createdAt: String
//    var id: Int { return userHelpInfId }
//}

import Foundation
import SwiftUI

struct HelpInfoWriteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var datePickerIsTapped = false
    @State private var selectedDate = Date()
    @State  var ans_congestion : String = ""
    @State  var ans_deskSize : String = ""
    @State  var ans_outletLocation : String = ""
    @State  var ans_outletCount : String = ""
    @State  var ans_light : String = ""
    @State  var ans_restroomLocation : String = ""
    @State  var ans_musicGenre : String = ""
    @State  var ans_atmosphere : String = ""
    var ansAllInput: Bool {
        // 모든 필드가 채워져 있어야 true를 반환합니다.
        !ans_congestion.isEmpty &&
        !ans_deskSize.isEmpty &&
        !ans_outletLocation.isEmpty &&
        !ans_outletCount.isEmpty &&
        !ans_light.isEmpty &&
        !ans_restroomLocation.isEmpty &&
        !ans_musicGenre.isEmpty &&
        !ans_atmosphere.isEmpty &&
        !datePickerIsTapped
    }
    
    
    //  var answerContainer : UserHelpInfo
    
    var body: some View {
        NavigationView{
            GeometryReader{ proxy in
                VStack{
                    ScrollView(){
                        VStack(alignment: .center){
                            VStack {
                                datePickerView()
                                    .onChange(of: selectedDate) { _ in
                                        datePickerIsTapped = true
                                    }
                            }//1stvstckend
                            
                            VStack(alignment: .leading, spacing: 16){
                                Text ("정보 등록하기")
                                    .font(Font.custom("S-Core Dream", size: 16))
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                Text ("등록해주시는 정보는 다른 유저들에게 큰 힘이 돼요! \n최대한 정확하게 작성해주세요 :)")
                                    .font(Font.custom("S-Core Dream", size: 9))
                                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 앉았던 책상은 어떻게 느껴졌나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        HStack{
                                            Button {
                                                
                                            }label: {
                                                
                                                ButtonLabelCreater(title: "넓었어요")
                                                
                                            }
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "적당했어요")
                                            }
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "부족했어요")
                                            }
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .padding(.leading, -40)
                                    
                                }//zstackend
                                
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 콘센트 개수는 어떻게 느껴졌나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        HStack{
                                            Button {
                                                
                                            }label: {
                                                // if(ans_outletCount == "넉넉했어요")
                                                ButtonLabelCreater(title: "넉넉했어요")
                                                
                                            }
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "적당했어요")
                                            }
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "부족했어요")
                                            }
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .padding(.leading, -40)
                                    
                                }//2nd zstackend
                                
                                ZStack{ // 콘센트
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 콘센트는 주로 어디에 있었나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        
                                        HStack{
                                            Text("주로")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            VStack{
                                                TextField ("ex) 책상 밑, 책상 위", text : $ans_outletLocation)
                                                    .font(Font.custom("S-Core Dream", size: 10))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                    .frame(width: 135)
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 135, height: 1)
                                                    .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                                            }
                                            
                                            Text("에 있어요")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .offset(x: -40)
                                    
                                }
                                ZStack{// 장실
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 화장실은 어디에 있었나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        
                                        HStack{
                                            Text("주로")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            VStack{
                                                TextField ("ex) 1층 카운터 옆", text : $ans_restroomLocation)
                                                    .font(Font.custom("S-Core Dream", size: 10))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                    .frame(width: 135)
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 135, height: 1)
                                                    .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                                            }
                                            
                                            Text("에 있어요")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .offset(x: -40)
                                }
                                ZStack{// 노래
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 카페에서 어떤 종류의 노래가 많이 나왔나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        
                                        HStack{
                                            Text("주로")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            VStack{
                                                TextField ("ex) 케이팝, 재즈", text : $ans_restroomLocation)
                                                    .font(Font.custom("S-Core Dream", size: 10))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                    .frame(width: 135)
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 135, height: 1)
                                                    .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                                            }
                                            
                                            Text("음악이 많이 나와요")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .offset(x:-20)
                                    
                                }
                                ZStack{//조명
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 카페 조명은 어떻게 느껴졌나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        HStack{
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "밝았어요")
                                                
                                            }
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "적당했어요")
                                            }
                                            Button {
                                                
                                            }label: {
                                                ButtonLabelCreater(title: "어두웠어요")
                                            }
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .padding(.leading, -40)
                                    
                                }
                                ZStack{// 분위기
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    VStack(alignment: .leading){
                                        
                                        Text("Q. 카페의 전체적인 분위기는 어떻게 느껴졌나요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            .padding(.bottom, 10)
                                        
                                        HStack{
                                            
                                            VStack{
                                                TextField ("ex) 조용한", text : $ans_restroomLocation)
                                                    .font(Font.custom("S-Core Dream", size: 10))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                                    .frame(width: 135)
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 135, height: 1)
                                                    .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                                            }
                                            
                                            Text("분위기")
                                                .font(Font.custom("S-Core Dream", size: 10))
                                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                            
                                            
                                        }
                                        .padding(.bottom, 16)
                                        Button {
                                            
                                        } label: {
                                            HStack{
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "circle")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                    
                                                }
                                                
                                                Text("기억나지 않아요")
                                                    .font(Font.custom("S-Core Dream", size: 8))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                                            }
                                        }
                                        
                                    }
                                    .offset(x:-20)
                                    
                                }
                                
                                
                            }//2ndvstck end
                            
                            
                        }
                        
                        
                        
                    }//scroll ed
                    .padding(.bottom, 80)
                    .navigationBarBackButtonHidden(true)
                    .offset(y: 45 + 32)
                    .overlay(alignment: .top){
                        headerView()
                    }
                    Button {
                        print("ans sender tapped")
                    } label: {
                        if ansAllInput {
                            
                            Rectangle()
                                .cornerRadius(12)
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 50, alignment: .center)
                                .foregroundStyle(CustomColors.primary05)
                                .overlay {
                                    Text("리뷰 게시하기")
                                        .font(Font.custom("S-Core Dream", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                }
                            
                        }
                        else{
                            Rectangle()
                                .cornerRadius(12)
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 50, alignment: .center)
                                .foregroundStyle(CustomColors.gray04)
                                .overlay {
                                    Text("리뷰 게시하기")
                                        .font(Font.custom("S-Core Dream", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                }
                            
                        }
                    }
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
                //.padding(.vertical, 0)
                
                //MARK: 가게 이름
                Text("shops[0].shopName")
                    .font(Font.custom("S-Core Dream", size: 14))
                    .foregroundStyle(.black)
                    .padding(.vertical, 12)
                
                Spacer(minLength: 0)
            }
            
            Spacer()
            
            Divider()
        }
        .background(CustomColors.white)
        .frame(height: 45)
    }
    
    @ViewBuilder
    func datePickerView()->some View{
        var date : String {
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy.MM.dd 방문"
            myDateFormatter.locale = Locale(identifier: "ko_KR")
            
            return myDateFormatter.string(from: selectedDate)
        }
        
        VStack(alignment: .leading, spacing: 28){
            Text("방문 날짜와 시간 등록하기")
                .font(Font.custom("S-CoreDream-6Bold", size: 16))
                .foregroundStyle(CustomColors.gray09)
                .padding(.leading, 24)
            
            
            if datePickerIsTapped{
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 345, height: 50)
                    .foregroundStyle(CustomColors.primary05)
                    .padding(.horizontal, 24)
                    .overlay{
                        Text(date)
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundStyle(.white)
                            .overlay{
                                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                    .blendMode(.destinationOver)
                                    .tint(CustomColors.primary05)
                            }
                        
                    }
            }
            else{
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 345, height: 50)
                    .foregroundStyle(CustomColors.gray02)
                    .padding(.horizontal, 24)
                    .overlay{
                        Text(date)
                            .font(Font.custom("S-Core Dream", size: 12))
                            .foregroundStyle(CustomColors.gray06)
                            .overlay{
                                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                    .blendMode(.destinationOver)
                                    .tint(CustomColors.primary05)
                            }
                    }
                
            }
        }
    }
    
}
@ViewBuilder
func ButtonLabelCreater (title : String) -> some View {
    Text(title)
        .padding(.vertical, 5) // 상하 패딩 적용
        .padding(.horizontal, 15) // 좌우 패딩 적용
        .font(.custom("S-Core Dream", size: 10))
        .multilineTextAlignment(.center)
        .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
        .background(Color.white) // 먼저 Text의 배경색을 설정
        .clipShape(RoundedRectangle(cornerRadius: 24)) // Text의 배경에 둥근 모서리 적용
        .overlay(
            RoundedRectangle(cornerRadius: 24) // Overlay로 RoundedRectangle 추가
                .stroke(CustomColors.primary05, lineWidth: 1) // 테두리 색상과 두께 설정
        )
    
}
@ViewBuilder
func ButtonLabelCreaterChosen (title : String) -> some View {
    Text(title)
        .padding(.vertical, 5) // 상하 패딩 적용
        .padding(.horizontal, 15) // 좌우 패딩 적용
        .font(.custom("S-Core Dream", size: 10))
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .background(CustomColors.primary05) // 먼저 Text의 배경색을 설정
        .clipShape(RoundedRectangle(cornerRadius: 24)) // Text의 배경에 둥근 모서리 적용
        .overlay(
            RoundedRectangle(cornerRadius: 24) // Overlay로 RoundedRectangle 추가
                .stroke(CustomColors.primary05, lineWidth: 1) // 테두리 색상과 두께 설정
        )
    
}
struct ButtonQuestion {
    let question: String
    let ans1: String
    let ans2: String
    let ans3: String
    let usage : String
    @State private var choice: String = ""
    
    init(question: String, ans1: String, ans2: String, ans3: String, usage : String) {
        self.question = question
        self.ans1 = ans1
        self.ans2 = ans2
        self.ans3 = ans3
        self.usage = usage
        // choice는 초기화하지 않음, 나중에 값 할당 가능
    }
    var body : some View {
        ZStack{//조명
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 345, height: 119)
                .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                .cornerRadius(12)
            VStack(alignment: .leading){
                
                Text(question)
                    .font(Font.custom("S-Core Dream", size: 12))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .padding(.bottom, 10)
                HStack{
                    
                    
                    Button {
                        choice = ans1
                    }label: {
                        if choice == ans1{
                            ButtonLabelCreaterChosen(title: ans1)
                        }
                        else{
                            ButtonLabelCreater(title: ans1)
                        }
                    }
                    
                    Button {
                        choice = ans1
                    }label: {
                        if choice == ans1{
                            ButtonLabelCreaterChosen(title: ans1)
                        }
                        else{
                            ButtonLabelCreater(title: ans1)
                        }
                    }
                    
                    Button {
                        choice = ans1
                    }label: {
                        if choice == ans1{
                            ButtonLabelCreaterChosen(title: ans1)
                        }
                        else{
                            ButtonLabelCreater(title: ans1)
                        }
                    }
                    
                }
                .padding(.bottom, 16)
                Button {
                    
                } label: {
                    HStack{
                        Button {
                            choice = "기억나지 않아요"
                        } label: {
                            if choice == "기억나지 않아요"{
                                Image(systemName: "circle.inset.filled")
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(CustomColors.primary05)
                            }
                            else {
                                Image(systemName: "circle")
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(CustomColors.primary05)
                            }
                        }
                        
                        Text("기억나지 않아요")
                            .font(Font.custom("S-Core Dream", size: 8))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                    }
                }
                
            }
            .padding(.leading, -40)
            
        }
    }
    
}






@ViewBuilder
//string
func ButtonQuestionCreater (question : String, ans1 : String, ans2 : String, ans3 : String, ansTarget : String) -> some View{
    
}

struct HelpInfoWriteView_Previews: PreviewProvider {
    static var previews: some View {
        HelpInfoWriteView(ans_congestion: "1", ans_deskSize: "1", ans_outletLocation: "1", ans_outletCount: "1", ans_light: "1", ans_restroomLocation: "1", ans_musicGenre: "1", ans_atmosphere: "1")
    }
}
