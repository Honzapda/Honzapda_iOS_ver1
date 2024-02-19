//
//  CurationTestView.swift
//  Honzapda
//
//  Created by 이재용 on 2/17/24.
//

import Foundation
import SwiftUI

struct CurationTestView : View {
    @Binding var gotoTest: Bool
    @State var progress : Int = 1
    @State var mood : String
    @State var keyword : String
    @State var menu : String
    @State var atmosphare : String
    var body: some View {
        GeometryReader { geometry in
            VStack{
                VStack(alignment: .leading) {
                    Button(action: {
                        gotoTest = false
                        print("backButton -> gotoCuration")
                        
                    }) {
                        Image("chevron.left")
                            .padding()
                        
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                    
                    Rectangle()
                        .frame(width: geometry.size.width * CGFloat(self.progress) / 4, height: 2)
                        .foregroundColor(CustomColors.primary05) // 프로그레스 바의 색상을 설정합니다.
                    
                    // 프로그레스를 업데이트하는 버튼 예시
                    
                }
                VStack{
                    ZStack {
                        if progress == 1 {
                            CTView1(progress: $progress, mood: $mood)
                                .frame(height : UIScreen.main.bounds.height * 0.6)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        } else if progress == 2 {
                            CTView2(progress: $progress, keyword: $keyword)
                                .frame(height : UIScreen.main.bounds.height * 0.6)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        } else if progress == 3 {
                            CTView3(progress: $progress, menu: $menu)
                                .frame(height : UIScreen.main.bounds.height * 0.6)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        } else if progress == 4 {
                            CTView4(atmosphare: $atmosphare , gotoTest: $gotoTest)
                                .frame(height : UIScreen.main.bounds.height * 0.6)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                    .animation(.default, value: progress)
                    
                    
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

struct CurationTestView_Previews: PreviewProvider {
    static var previews: some View {
        // Binding 변수를 프리뷰에서 사용하기 위해 임시적으로 처리
        CurationTestView(gotoTest: .constant(true), mood: "none", keyword: "none", menu: "none", atmosphare: "none")
//          CTView1(progress: .constant(1), mood: .constant("bad"))
//         CTView2(progress: .constant(1), keyword: .constant("휴식"))
//        
//          CTView3(progress: .constant(1), menu: .constant("coffee"))
//        CTView4(atmosphare: .constant("quiet"), gotoTest: .constant(true))
       
    }
}


struct CTView4 : View {

    @Binding var atmosphare : String
    @Binding var gotoTest : Bool
    var body: some View {
        ZStack(alignment: .top){
            Image("Test_Background")
                .resizable()
                .scaledToFill()
           
            VStack(alignment: .leading, spacing: 30){
                Text("오늘 가고 싶은\n카페 분위기를 알려주세요!")
                    .font(Font.custom("S-Core Dream", size: 26))
                    .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                    .padding(.leading, 14)
                    
                //선택 안됨
                if atmosphare == "none"{
                    
                    HStack(spacing: -5){
                        Button {
                            print( "quiet")
                            atmosphare = "quiet"
                           gotoTest = false
                        } label: {
                            cuButtonLabelCreater3(num: 4)
                            
                        }
                        
                        Button {
                            print( "drink")
                            atmosphare = "drink"
                            gotoTest = false
                        } label: {
                            
                            cuButtonLabelCreater3(num: 5)
                        }
                        
                        Button {
                            print( "dessert")
                            atmosphare = "dessert"
                            gotoTest = false
                        } label: {
                            cuButtonLabelCreater3(num: 6)
                            
                        }
                        
                    }
                    .frame(width : UIScreen.main.bounds.width * 0.9)
                }
                
                else{
                    
                    HStack(spacing: -5){
                        Button {
                            atmosphare = "coffee"
                        } label: {
                            if atmosphare == "coffee"{
                                cuButtonLabelCreater3(num: 1)
                                
                            }
                            else{
                                cuButtonLabelCreater3(num: 4)
                                
                            }
                        }
                        
                        
                        Button {
                            atmosphare = "drink"
                        } label: {
                            if atmosphare == "drink"{
                                cuButtonLabelCreater3(num: 2)
                                
                            }
                            else{
                                cuButtonLabelCreater3(num: 5)
                                
                            }
                        }
                        
                        
                        Button {
                            atmosphare = "dessert"
                        } label: {
                            if atmosphare == "dessert"{
                                cuButtonLabelCreater3(num: 3)
                                
                            }
                            else{
                                cuButtonLabelCreater3(num: 6)
                                
                            }
                        }
                    }
                    .frame(width : UIScreen.main.bounds.width * 0.9)
                }
                //뭐라도 선택됨
            }
            .offset(y:200)
            .frame(width : UIScreen.main.bounds.width * 0.9, alignment: .leading)
        }
    }
}
struct cuButtonLabelCreater3 : View {
    let num : Int
    var body: some View {
        
        if num == 1 {
            ZStack{
                Image("Cu_Quiet_tap")
                    .resizable()
                    .frame(width: 99, height: 134)
                    .shadow(radius: 3)
                Text("쾌적하고\n조용한 분위기")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                    .multilineTextAlignment(.center)
                    .offset(y: 20)
                
            }
            
        }
        else if num == 2{
            ZStack{
                Image("Cu_Noisy_tap")
                    .resizable()
                    .frame(width: 99, height: 134)
                    .shadow(radius: 3)
                Text("적당한\n소음")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundColor(Color(red: 0.54, green: 0.9, blue: 0.72))
                    .multilineTextAlignment(.center)
                    .offset(y: 20)
                
            }
            
        }
        else if num == 3{
            ZStack{
                Image("Cu_Hotplace_tap")
                    .resizable()
                    .frame(width: 99, height: 134)
                    .shadow(radius: 3)
                Text("활기찬\n핫플레이스")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundColor(Color(red: 0.95, green: 0.54, blue: 0.41))
                    .multilineTextAlignment(.center)
                    .offset(y: 20)
                
            }
            
        }
        else if num == 4{
            ZStack(){
                Image("Cu_Quiet")
                    .resizable()
                    .frame(width: 99, height: 134)
                    .shadow(radius: 3)
                Text("쾌적하고\n조용한 분위기")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                    .multilineTextAlignment(.center)
                    .offset(y: 20)
                
            }
        }
        else if num == 5{
            ZStack{
                Image("Cu_Noisy")
                    .resizable()
                    .frame(width: 99, height: 134)
                    .shadow(radius: 3)
                Text("적당한\n소음")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundColor(Color(red: 0.54, green: 0.9, blue: 0.72))
                    .multilineTextAlignment(.center)
                    .offset(y: 20)
                
            }
        }
        else if num == 6{
            ZStack{
                Image("Cu_Hotplace")
                    .resizable()
                    .frame(width: 99, height: 134)
                    .shadow(radius: 3)
                Text("활기찬\n핫플레이스")
                    .font(Font.custom("S-Core Dream", size: 10))
                    .foregroundColor(Color(red: 0.95, green: 0.54, blue: 0.41))
                    .multilineTextAlignment(.center)
                    .offset(y: 20)
            }
        }
        
    }
}

struct CTView1 : View {
    @Binding var progress : Int
    @Binding var mood : String
    var body: some View {
        ZStack(){
            Image("Test_Background")
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading, spacing: 30){
                Text("오늘의 기분은\n어때요?")
                    .font(Font.custom("S-Core Dream", size: 26))
                    .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                    .padding(.leading, 14)
                //선택 안됨
                if mood == "none"{
                    
                    VStack(spacing: -5){
                        Button {
                            print( "good")
                            mood = "good"
                            progress += 1
                        } label: {
                            cuButtonLabelCreater(num: 1)
                            
                        }
                        
                        Button {
                            print( "normal")
                            mood = "normal"
                            progress += 1
                        } label: {
                            
                            cuButtonLabelCreater(num: 2)
                        }
                        
                        Button {
                            print( "bad")
                            mood = "bad"
                            progress += 1
                        } label: {
                            cuButtonLabelCreater(num: 3)
                            
                        }
                        
                    }
                }
                
                else{
                    
                    VStack(spacing: -5){
                        Button {
                            mood = "good"
                        } label: {
                            if mood == "good"{
                                cuButtonLabelCreater(num: 1)
                                
                            }
                            else{
                                cuButtonLabelCreater(num: 4)
                                
                            }
                        }
                        
                        
                        Button {
                            mood = "normal"
                        } label: {
                            if mood == "normal"{
                                cuButtonLabelCreater(num: 2)
                                
                            }
                            else{
                                cuButtonLabelCreater(num: 5)
                                
                            }
                        }
                        
                        
                        Button {
                            mood = "bad"
                        } label: {
                            if mood == "bad"{
                                cuButtonLabelCreater(num: 3)
                                
                            }
                            else{
                                cuButtonLabelCreater(num: 6)
                                
                            }
                        }
                    }
                }
                //뭐라도 선택됨
            }
            .frame(width : UIScreen.main.bounds.width * 0.9, alignment: .leading)
        }
    }
}

struct CTView2 : View {
    @Binding var progress : Int
    @Binding var keyword : String
    let choiceArr : [[String]] = [["휴식", "감성 사진 찍기"], ["여행", "활발한 대화"], ["회의", "독서", "업무"], ["핫플", "공부"]]
    var body: some View {
        ZStack(alignment: .top){
            Image("Test_Background")
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading, spacing: 30){
                Text("가장 마음에 드는\n키워드를 선택해주세요!")
                    .font(Font.custom("S-Core Dream", size: 26))
                    .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                    .padding(.leading, 14)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                
                VStack{
                    ForEach(0..<choiceArr.count, id: \.self){
                        rowIndex in
                        HStack(spacing: 10){
                            ForEach(choiceArr[rowIndex], id : \.self){ choice in
                                Button {
                                    keyword = choice
                                    progress += 1
                                } label: {
                                    if keyword == choice {
                                        cuSmallButtonLabelCreater2(title: choice)
                                    }
                                    else{
                                        cuSmallButtonLabelCreater(title: choice)
                                    }
                                }

                                
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .padding(.top , 30)
                
            }
            .offset(y: 200)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            
        }
    }
}

struct CTView3 : View {
    @Binding var progress : Int
    @Binding var menu : String
    var body: some View {
        ZStack(alignment : .top){
            Image("Test_Background")
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading, spacing: 30){
                Text("오늘 먹고 싶은\n메뉴를 골라주세요!")
                    .font(Font.custom("S-Core Dream", size: 26))
                    .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                    .padding(.leading, 14)
                //선택 안됨
                if menu == "none"{
                    
                    VStack(spacing: -5){
                        Button {
                            print( "coffee")
                            menu = "coffee"
                            progress += 1
                        } label: {
                            cuButtonLabelCreater2(num: 4)
                            
                        }
                        
                        Button {
                            print( "drink")
                            menu = "drink"
                            progress += 1
                        } label: {
                            
                            cuButtonLabelCreater2(num: 5)
                        }
                        
                        Button {
                            print( "dessert")
                            menu = "dessert"
                            progress += 1
                        } label: {
                            cuButtonLabelCreater2(num: 6)
                            
                        }
                        
                    }
                }
                
                else{
                    
                    VStack(spacing: -5){
                        Button {
                            menu = "coffee"
                            
                        } label: {
                            if menu == "coffee"{
                                cuButtonLabelCreater2(num: 1)
                                
                            }
                            else{
                                cuButtonLabelCreater2(num: 4)
                                
                            }
                        }
                        
                        
                        Button {
                            menu = "drink"
                        } label: {
                            if menu == "drink"{
                                cuButtonLabelCreater2(num: 2)
                                
                            }
                            else{
                                cuButtonLabelCreater2(num: 5)
                                
                            }
                        }
                        
                        
                        Button {
                            menu = "dessert"
                        } label: {
                            if menu == "dessert"{
                                cuButtonLabelCreater2(num: 3)
                                
                            }
                            else{
                                cuButtonLabelCreater2(num: 6)
                                
                            }
                        }
                    }
                }
                //뭐라도 선택됨
            }
            .offset(y: 200)
            .frame(width : UIScreen.main.bounds.width * 0.9, alignment: .leading)
        }
    }
}
