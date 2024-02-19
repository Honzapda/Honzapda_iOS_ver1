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

struct HelpInfoWriteView: View  {
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
    private var shopId : Int
    private var formatter : DateFormatter
    
//    let buttonAns1 : [String] = ["large", "medium", "small", "none"]
//    let buttonAns2 : [String] = ["enough", "adequate", "lack","none"]
//    let buttonAns3 : [String] = ["bright", "adequate", "dark","none"]
    let buttonAns1 : [String] = ["넓었어요", "적당했어요", "작았어요", "none"]
    let buttonAns2 : [String] = ["넉넉했어요", "적당했어요", "부족했어요","none"]
    let buttonAns3 : [String] = ["밝았어요", "적당했어요", "어두웠어요","none"]
    let congestionPercent : [String] = ["0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
    init (ShopId : Int){
        shopId = ShopId
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    }
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
        datePickerIsTapped
    }
    private func dateStringChanger(date: Date)  -> String{
        let dateFormatter = DateFormatter()
        // 한국 시간대로 DateFormatter의 TimeZone 설정
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        // 출력 포맷 설정
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        // 입력받은 Date를 한국 시간 문자열로 변환
        let kstDateString = dateFormatter.string(from: date)
        print("KST Date String: \(kstDateString)")
        return kstDateString
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
                                        print(selectedDate)
                                    }
                            }//1stvstckend
                            
                            VStack(alignment: .leading, spacing: 16){
                                Text ("정보 등록하기")
                                    .font(Font.custom("S-Core Dream", size: 16))
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                Text ("등록해주시는 정보는 다른 유저들에게 큰 힘이 돼요! \n최대한 정확하게 작성해주세요 :)")
                                    .font(Font.custom("S-Core Dream", size: 9))
                                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                    .padding(.bottom, 20)
                                
                                //con
                                ZStack{//congestion
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 345, height: 119)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                        .cornerRadius(12)
                                    
                                    VStack(alignment: .leading, spacing: 25){
                                        Text ("Q. 카페가 얼마나 혼잡한가요?")
                                            .font(Font.custom("S-Core Dream", size: 12))
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                        HStack{
                                            
                                            ForEach(congestionPercent, id: \.self){ percent in
                                                
                                                Button {
                                                    ans_congestion = percent
                                                    print(ans_congestion , " Chosen")
                                                } label: {
                                                    if ans_congestion == percent{
                                                        Image(systemName: "circle.inset.filled")
                                                            .frame(width: 10, height: 10)
                                                            .foregroundColor(CustomColors.primary05)
                                                            .padding(.trailing, -3)
                                                        
                                                    }
                                                    else{
                                                        Image(systemName: "circle")
                                                            .frame(width: 10, height: 10)
                                                            .foregroundColor(CustomColors.primary05)
                                                            .padding(.trailing, -3)
                                                        
                                                    }
                                                }
                                                if(percent != "100"){
                                                    Rectangle().frame(width:10, height: 1)
                                                        .foregroundStyle(CustomColors.primary05)
                                                        .padding(.trailing, -3)
                                                    
                                                    
                                                }
                                                
                                            }
                                        }
                                        HStack{
                                            Button {
                                                ans_congestion = "none"
                                            } label: {
                                                if ans_congestion == "none"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 345-40, alignment: .leading)
                                }
                                
                                
                                
                                
                                
                                
                                ZStack(){//desksize
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
                                                ans_deskSize = buttonAns1[0]
                                            }label: {
                                                if(ans_deskSize == buttonAns1[0]){
                                                    ButtonLabelCreaterChosen(title: buttonAns1[0])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns1[0])
                                                }
                                            }
                                            
                                            Button {
                                                ans_deskSize = buttonAns1[1]
                                            }label: {
                                                if(ans_deskSize == buttonAns1[1]){
                                                    ButtonLabelCreaterChosen(title: buttonAns1[1])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns1[1])
                                                }
                                            }
                                            Button {
                                                ans_deskSize = buttonAns1[2]
                                            }label: {
                                                if(ans_deskSize == buttonAns1[2]){
                                                    ButtonLabelCreaterChosen(title: buttonAns1[2])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns1[2])
                                                }
                                            }
                                            
                                        }
                                        .padding(.bottom, 16)
                                        HStack{
                                            Button {
                                                ans_deskSize = "none"
                                            } label: {
                                                if ans_deskSize == "none"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 345-40, alignment: .leading)
                                    
                                    
                                }//zstackend
                                
                                
                                ZStack{ // outletcount
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
                                                ans_outletCount = buttonAns2[0]
                                            }label: {
                                                if(ans_outletCount == buttonAns2[0]){
                                                    ButtonLabelCreaterChosen(title: buttonAns2[0])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns2[0])
                                                }
                                            }
                                            Button {
                                                ans_outletCount = buttonAns2[1]
                                            }label: {
                                                if(ans_outletCount == buttonAns2[1]){
                                                    ButtonLabelCreaterChosen(title: buttonAns2[1])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns2[1])
                                                }
                                            }
                                            Button {
                                                ans_outletCount = buttonAns2[2]
                                            }label: {
                                                if(ans_outletCount == buttonAns2[2]){
                                                    ButtonLabelCreaterChosen(title: buttonAns2[2])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns2[2])
                                                }
                                            }
                                            
                                        }
                                        .padding(.bottom, 16)
                                        HStack{
                                            Button {
                                                ans_outletCount = "none"
                                            } label: {
                                                if ans_outletCount == "none"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 305, alignment: .leading)
                                    
                                    
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
                                        
                                        HStack{
                                            Button {
                                                ans_outletLocation = "기억나지 않아요"
                                            } label: {
                                                if ans_outletLocation == "기억나지 않아요"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 345-40, alignment: .leading)
                                    
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
                                        HStack{
                                            Button {
                                                ans_restroomLocation = "기억나지 않아요"
                                            } label: {
                                                if ans_restroomLocation == "기억나지 않아요"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 305, alignment: .leading)
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
                                                TextField ("ex) 케이팝, 재즈", text : $ans_musicGenre)
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
                                        HStack{
                                            Button {
                                                ans_musicGenre = "기억나지 않아요"
                                            } label: {
                                                if ans_musicGenre == "기억나지 않아요"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 305, alignment: .leading)
                                    
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
                                                ans_light = buttonAns3[0]
                                            }label: {
                                                if(ans_light == buttonAns3[0]){
                                                    ButtonLabelCreaterChosen(title: buttonAns3[0])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns3[0])
                                                }
                                            }
                                            Button {
                                                ans_light = buttonAns3[1]
                                            }label: {
                                                if(ans_light == buttonAns3[1]){
                                                    ButtonLabelCreaterChosen(title: buttonAns3[1])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns3[1])
                                                }
                                            }
                                            Button {
                                                ans_light = buttonAns3[2]
                                            }label: {
                                                if(ans_light == buttonAns3[2]){
                                                    ButtonLabelCreaterChosen(title: buttonAns3[2])
                                                }
                                                else{
                                                    ButtonLabelCreater(title: buttonAns3[2])
                                                }
                                            }
                                            
                                        }
                                        .padding(.bottom, 16)
                                        HStack{
                                            Button {
                                                ans_light = "기억나지 않아요"
                                            } label: {
                                                if ans_light == "기억나지 않아요"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 305, alignment: .leading)
                                    
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
                                                TextField ("ex) 조용한", text : $ans_atmosphere)
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
                                        HStack{
                                            Button {
                                                ans_atmosphere = "기억나지 않아요"
                                            } label: {
                                                if ans_atmosphere == "기억나지 않아요"{
                                                    Image(systemName: "circle.inset.filled")
                                                        .frame(width: 10, height: 10)
                                                        .foregroundColor(CustomColors.primary05)
                                                }
                                                else {Image(systemName: "circle")
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
                                    .frame(width: 305, alignment: .leading)
                                    
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
                        print("shopId: \(shopId)")
                        print("visitDateTime: \(dateStringChanger(date: selectedDate))")
                        print("congestion: \(ans_congestion)")
                        print("deskSize: \(ansChangerForButton1(title: ans_deskSize))")
                        print("outletCount: \(ansChangerForButton23(title: ans_outletCount))")
                        print("light: \(ansChangerForButton23(title: ans_light))")
                        print("outletLocation: \(ansChnager(title: ans_outletLocation))")
                        print("restroomLocation: \(ansChnager(title: ans_restroomLocation))")
                        print("musicGenre: \(ansChnager(title: ans_musicGenre))")
                        print("atmosphere: \(ansChnager(title: ans_atmosphere))")
                        print("imageUrls: \(["String"])")

                        postUserHelpInfo(shopId:shopId,
                                         visitDateTime: dateStringChanger(date: selectedDate),
                                         congestion: ans_congestion,
                                         deskSize: ansChangerForButton1(title: ans_deskSize) ,
                                         outletCount: ansChangerForButton23(title: ans_outletCount) ,
                                         light:ansChangerForButton23(title: ans_light) ,
                                         outletLocation:ansChnager(title: ans_outletLocation) ,
                                         restroomLocation: ansChnager(title: ans_restroomLocation),
                                         musicGenre: ansChnager(title: ans_musicGenre) ,
                                         atmosphere:  ansChnager(title: ans_atmosphere),
                                         imageUrls: ["String"]) // 예상 답변 ->
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
                .navigationBarBackButtonHidden()
                .background(Color.white)
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
        .navigationBarBackButtonHidden()
    }
    
}

private func ansChnager(title : String) -> String{
    if title == "기억나지 않아요"{
        return "none"
    }
    else {return title}
}
private func ansChangerForButton23 (title : String) -> String { // ans2,3
    
    switch title {
    case "넉넉했어요":
        return "enough"
    case "적당했어요":
        return "adequate"
    case "부족했어요":
        return "lack"
    case "밝았어요":
        return "bright"
    case "어두웠어요":
        return "dark"
    default:
        return "none"
    }
    
}
private func ansChangerForButton1 (title : String) -> String { // ans2,3
    
    switch title {
    case "넓었어요":
        return "large"
    case "적당했어요":
        return "medium"
    case "작았어요":
        return "small"
    
    default:
        return "none"
    }
    
}
////    let buttonAns1 : [String] = ["large", "medium", "small", "none"]
////    let buttonAns2 : [String] = ["enough", "adequate", "lack","none"]
////    let buttonAns3 : [String] = ["bright", "adequate", "dark","none"]
//    let buttonAns1 : [String] = ["넓었어요", "적당했어요", "작았어요", "none"]
//    let buttonAns2 : [String] = ["넉넉했어요", "적당했어요", "부족했어요","none"]
//    let buttonAns3 : [String] = ["밝았어요", "적당했어요", "어두웠어요","none"]

//
//struct HelpInfoWriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpInfoWriteView(ans_congestion: "1", ans_deskSize: "1", ans_outletLocation: "1", ans_outletCount: "1", ans_light: "1", ans_restroomLocation: "1", ans_musicGenre: "1", ans_atmosphere: "1")
//    }
//}

