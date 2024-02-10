//
//  OnboardingView.swift
//  Honzapda
//
//  Created by 이재용 on 1/20/24.
//

import SwiftUI


struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding", store: UserDefaults.standard) var hasSeenOnboarding = false
    
    // 온보딩을 보았던 기록을 저장합니다
    
    let onboardingPages: [OnboardingPage] = [
        OnboardingPage(
            
            mainText : "공부",
            subText: "어느 카페 가지? 자리가 있을까?\n더 이상 고민하지 마세요.",
            imageName: "img_onboarding_study-2"
            
            
        ),
        OnboardingPage(
            mainText : "자리",
            subText: "어느 카페 가지? 자리가 있을까?\n더 이상 고민하지 마세요.",
            imageName: "img_onboarding_seat"
         
            
        ),
        
        OnboardingPage(
            mainText : "분위기",
            subText: "조용한 분위기? 약간은 시끄러운 분위기?\n혼잡다에서 미리 살펴보세요!",
            imageName: "img_onboarding_mood"
          
        ),
        
        OnboardingPage(
            mainText : "콘센트",
            subText: "조용한 분위기? 약간은 시끄러운 분위기?\n혼잡다에서 미리 살펴보세요!",
            imageName: "img_onboarding_plug"
        )
    ]
    
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                // 배경 이미지
                Image("Background_Onboarding")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                
                //페이지 표시 인디케이터
                HStack {
                    ForEach(0..<4, id: \.self) { index in
                        Image(index == currentPage ? "Ellipse_Full" : "Ellipse_Empty")
                            .resizable()
                            .frame(width: 4, height: 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, -2)
                    }
                }
                .offset(y: -400)
                
                
                TabView(selection: $currentPage) {// 탭 뷰 사용
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        VStack { // 메인텍스트 서브텍스트 이미지
                            VStack{
                                HStack{
                                    Text("카페에서")
                                        .modifier(OnboardingTitleModifier())
                                    Text(onboardingPages[index].mainText)
                                        .modifier(OnboardingTitleModifier2())
                                        .padding(.trailing, -7)
                                    Text("는")
                                        .modifier(OnboardingTitleModifier())
                                }
                                .padding(.bottom, 3)
                                Text("포기할 수 없으니까!")
                                    .modifier(OnboardingTitleModifier())
                            }
                            .padding()
                            
                            
                            Text(onboardingPages[index].subText)
                                .modifier(OnboardingSubtitleModifier())
                            Image(onboardingPages[index].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250)
                                .padding()
                        }
                        .tag(index)
                        
                    }
                }
                .frame(width: 500, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .offset(y: -170)
                .tabViewStyle(PageTabViewStyle())
                .onAppear(){
                    hasSeenOnboarding = true
                }
                
                VStack{
                    //MARK: Loginbuttons
//                    Button(action:{
//                        print("user login tapped")
//
//                    })
//                    {
//                        Text("유저로 로그인하기")
//                    }.modifier(UserLoginButtonModifier())
//                        .padding(.horizontal)
                    NavigationLink(destination: LoginView()) {
                           Text("유저로 로그인하기")
                       }
                       .modifier(UserLoginButtonModifier())
                       .padding(.horizontal)
                    
                    
                    
                    //                        NavigationLink(destination: LoginView()) {
                    //                            Text("유저 로그인")
                    //                        }.modifier(UserLoginButtonModifier())
                    //                         .padding(.horizontal)
                    //
                    
                    AppleLoginButtons()
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    HStack{
                        Text("사장님으로 시작하신다면?")
                            .font(.custom("S-CoreDream-5Medium", size: 10))
                            .foregroundColor(CustomColors.gray08)
                            .padding(.trailing, -2)
                        
                        Button {
                            print("business button tapped")
                        } label: {
                            Text("비즈니스 계정으로 로그인하기")
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .foregroundColor(CustomColors.primary06)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width)
                .offset(y: 100)
                
                
            }//zstack ends
            
        }//네비게이션 엔드
        
        }// body end
    }

struct OnboardingPage {
    
   
    let mainText : String
    let subText: String
    let imageName: String
    
   
}
struct LoginButton: View {
    var body: some View {
        // 로그인 버튼 UI 구현
        // 이전 로그인 수단에 따라 다른 내용 표시
        // 예: Button("유저 로그인") { /* 로그인 액션 구현 */ }
        
        Button(action:{
            print("user login tapped")
        
        })
        {
            Text("유저로 로그인하기")
                
        }.modifier(UserLoginButtonModifier())
    }
}


struct AppleLoginButtons: View {
    var body: some View {
        // 로그인 버튼 UI 구현
        // 이전 로그인 수단에 따라 다른 내용 표시
        // 예: Button("유저 로그인") { /* 로그인 액션 구현 */ }
        Button(action:{
            print("apple login tapped")
        })
        {
            HStack{
                Image(systemName: "applelogo")
                Text("Apple로 계속하기")
            }
            .modifier(AppleLoginButtonModifier())
            
              
        }
        
    }
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}



/*
 사용된 기술
 1. @State -> 값 변동시 코드 실행
 @State의 정의 및 사용법
 SwiftUI에서 @State는 사용자 인터페이스의 특정 부분의 상태를 저장하고 추적하기 위한 프로퍼티 래퍼입니다. @State를 사용하여 해당 뷰가 소유한 데이터를 관리할 수 있으며, 이 데이터가 변경될 때마다 뷰가 자동으로 업데이트됩니다.

 기본 특징

 @State는 주로 뷰 내부에서만 사용되는 간단한 데이터에 적합합니다.
 값이 변경될 때 뷰의 바디가 다시 호출되어 UI가 업데이트됩니다.
 @State 변수는 private으로 선언되어야 하며, 다른 뷰와 직접 공유되지 않습니다.
 사용 방법

 @State로 선언된 변수는 변수 앞에 @State 키워드를 붙여서 선언합니다.
 주로 사용자 입력, UI 상태 등 변동 가능한 값에 사용됩니다.
 
 2. @Appstorage - userDefaults
 3. TabView **중요
 4. modifier -> 코드 반복사용을 위해
 5. UIScreen.main.bound.width -> 기기의 크기를 알아내기 위해서 사용
 6. @main -> 진입점 설정
 */

