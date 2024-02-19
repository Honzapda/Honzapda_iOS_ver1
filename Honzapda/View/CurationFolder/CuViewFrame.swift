//
//  CuViewFrame.swift
//  Honzapda
//
//  Created by 이재용 on 2/18/24.
//

import Foundation
import SwiftUI

struct cuSmallButtonLabelCreater : View {
    let title : String
    var body: some View{
        Text(title)
            .font(.custom("S-CoreDream-5Medium", size: 18))
            .foregroundColor(CustomColors.primary05)
            .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(radius: 3 , x: 1, y:3)
                
            )
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
            .fixedSize(horizontal: true, vertical: false)
    }
}
struct cuSmallButtonLabelCreater2 : View {
    let title : String
    var body: some View{
        Text(title)
            .font(.custom("S-CoreDream-5Medium", size: 18))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(CustomColors.primary05)
                    .shadow(radius: 3 , x: 1, y:3)
                
            )
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 6, trailing: 4))
            .fixedSize(horizontal: true, vertical: false)
    }
}

struct cuButtonLabelCreater : View {
    let num : Int
    var body: some View {
        
        if num == 1 {
            ZStack{
                Image("Cu_Goodday_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("좋아요!\n카페 가기 좋은 날이에요 :)")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .offset(x : -60)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        else if num == 2{
            ZStack{
                Image("Cu_Normalday_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("좋지도 나쁘지도 않은\n보통의 기분이에요 :|")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .offset(x : -70)
            }
        }
        else if num == 3{
            ZStack{
                Image("Cu_Badday_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("기분이 좋지 않아\n기분 전환이 필요해요 :(")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .offset(x : -70)
            }
        }
        else if num == 4{
            ZStack{
                
                Image("Cu_Goodday_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("좋아요!\n카페 가기 좋은 날이에요 :)")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .offset(x : -60)
                Rectangle()
                    .fill(Color.white.opacity(0.5)) // 50% 투명도의 흰색
                // Rectangle의 크기를 조정하여 텍스트 영역에 맞춤
                    .scaledToFill() // 예시 크기, 실제 필요에 따라 조정
                    .frame(height: 110)
                    .cornerRadius(10) // 선택적: 모서리를 둥글게
                    .offset(y:2)
            }
        }
        else if num == 5{
            ZStack{
                Image("Cu_Normalday_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("좋지도 나쁘지도 않은\n보통의 기분이에요 :|")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .offset(x : -70)
                Rectangle()
                    .fill(Color.white.opacity(0.5)) // 50% 투명도의 흰색
                // Rectangle의 크기를 조정하여 텍스트 영역에 맞춤
                    .scaledToFill() // 예시 크기, 실제 필요에 따라 조정
                    .frame(height: 110)
                    .cornerRadius(10) // 선택적: 모서리를 둥글게
                    .offset(y:2)
            }
        }
        else if num == 6{
            ZStack{
                Image("Cu_Badday_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("기분이 좋지 않아\n기분 전환이 필요해요 :(")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .offset(x : -70)
                Rectangle()
                    .fill(Color.white.opacity(0.5)) // 50% 투명도의 흰색
                // Rectangle의 크기를 조정하여 텍스트 영역에 맞춤
                    .scaledToFill() // 예시 크기, 실제 필요에 따라 조정
                    .frame(height: 110)
                    .cornerRadius(10) // 선택적: 모서리를 둥글게
                    .offset(y:2)
            }
        }
        
    }
}

struct cuButtonLabelCreater2 : View {
    let num : Int
    var body: some View {
        
        if num == 1 {
            ZStack{
                Image("Cu_Coffemenu_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("카페의 정석!\n커피 메뉴")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                    .multilineTextAlignment(.leading)
                    .offset(x : -90)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        else if num == 2{
            ZStack{
                Image("Cu_Drinkmenu_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("그래도 당 충전은 해야지!\n달달한 음료 메뉴")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(Color(red: 0.54, green: 0.9, blue: 0.72))
                    .multilineTextAlignment(.leading)
                    .offset(x : -50)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        else if num == 3{
            ZStack{
                Image("Cu_Dessert_tap")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("카페는 디저트지!\n디저트 메뉴")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(Color(red: 0.95, green: 0.54, blue: 0.41))
                    .multilineTextAlignment(.leading)
                    .offset(x : -80)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        else if num == 4{
            ZStack(){
                Image("Cu_Coffeemenu")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("카페의 정석!\n커피 메뉴")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(Color(red: 0.29, green: 0.32, blue: 0.91))
                    .multilineTextAlignment(.leading)
                    .offset(x : -90)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        else if num == 5{
            ZStack{
                Image("Cu_Drinkmenu")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("그래도 당 충전은 해야지!\n달달한 음료 메뉴")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(Color(red: 0.54, green: 0.9, blue: 0.72))
                    .multilineTextAlignment(.leading)
                    .offset(x : -50)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        else if num == 6{
            ZStack{
                Image("Cu_Dessert")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 3)
                Text("카페는 디저트지!\n디저트 메뉴")
                    .font(Font.custom("S-CoreDream-6Bold", size: 16))
                    .foregroundColor(Color(red: 0.95, green: 0.54, blue: 0.41))
                    .multilineTextAlignment(.leading)
                    .offset(x : -80)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        
    }
}


