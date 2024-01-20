//
//  SplashView.swift
//  Honzapda
//
//  Created by 이재용 on 1/20/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        
        ZStack {
            
            Image("Background_Splash")
                .resizable()
                .scaledToFill() // 이미지를 화면 크기에 맞게 조정
                .edgesIgnoringSafeArea(.all)
                
            
            Text("카페의 모든 정보가 내 손 안에!")
              .font(
                Font.custom("PyeongChangPeace-Light", size: 16)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.white)
                .offset(x: 0, y: -150)
                
            Image("img_splash_logo 1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 162.22166, height: 202.175)
            
            Text("HONZAPDA")
              .font(
                Font.custom("PyeongChangPeace-Bold", size: 32)
                  .weight(.bold)
              )
              .foregroundColor(.white)
              .offset(x:0, y: 150)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // ZStack을 화면 크기에 맞게 조정
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

