//
//  OnboardingFont.swift
//  Honzapda
//
//  Created by 이재용 on 1/20/24.
//



import SwiftUI

struct OnboardingTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("S-CoreDream-5Medium", size: 20))
            .multilineTextAlignment(.center)
            .foregroundColor(CustomColors.gray10)
    }
}
struct OnboardingTitleModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("S-CoreDream-6Bold", size: 20))
            .multilineTextAlignment(.center)
            .foregroundColor(CustomColors.primary05)
    }
}

struct OnboardingSubtitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("S-CoreDream-5Medium", size: 12))
            .multilineTextAlignment(.center)
            .foregroundColor(CustomColors.gray05)
    }
}



struct UserLoginButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity) // 너비를 최대로 설정
                            .padding() // 내부 여백
                            .frame(height: 40) // 높이 설정
                            .background(CustomColors.primary05) // 배경 색상
                            .foregroundColor(.white) // 글자 색상
                            .cornerRadius(10) // 모서리를 둥글게
                            .font(Font.custom("S-CoreDream-5Medium", size: 14))
    }
}

struct AppleLoginButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity) // 너비를 최대로 설정
                        .padding() // 내부 여백
                        .frame(height: 40) // 높이 설정
                        .background(Color.black) // 배경 색상
                        .foregroundColor(.white) // 글자 색상
                        .cornerRadius(10) // 모서리를 둥글게
                        .font(Font.custom("S-CoreDream-5Medium", size: 14))
    }
}
