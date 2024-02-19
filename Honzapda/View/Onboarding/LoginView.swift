
//
//  LoginView.swift
//  Honzapda
//
//  Created by 이재용 on 2/4/24.
//

import SwiftUI


struct LoginView : View {
    @State private var id: String = ""
    @State private var password : String = ""
    @State private var idpwEntered : Bool = false
    @State private var loginButtonEnable : Bool = false
    @State private var isActive: Bool = false
    @State private var passwordMasking : Bool = true
    
    @EnvironmentObject var userStateViewModel: UserStateViewModel
    
    func updateLoginButtonEnable() {
        loginButtonEnable = !id.isEmpty && !password.isEmpty
    }
    
    var body : some View {
        
        NavigationView{
            ZStack{
                NavigationLink(destination: MainTapView(),isActive: $isActive){
                    EmptyView()
                } // HomeView()를 tasteView로 변경해서 쓰시면 됩니다.
                Image("LoginBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
                    Text("로그인")
                        .font(Font.custom("S-Core Dream", size: 24))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                        .padding(.top, 48)
                        .padding(.leading, 32)
                    Spacer()
                    
                    Text("서비스 이용을 위해 HONZAPDA 계정으로 로그인하세요!")
                        .padding(.leading, 32)
                        .padding(.top, -10)
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                    
                    
                    Text("아이디")
                        .font(Font.custom("S-Core Dream", size: 12))
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                        .padding(.leading, 32)
                        .padding(.top, 33)
                    
                    Spacer()
                    
                    TextField ("아이디 입력", text : $id)
                        .padding(15)
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                        .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal,32)
                        .padding(.top, -10)
                    
                    
                    Spacer()
                    
                    
                    Text("비밀번호")
                        .font(Font.custom("S-Core Dream", size: 12))
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                        .padding(.leading, 32)
                    
                    
                    Spacer()
                    
                    if passwordMasking {
                        ZStack{
                            SecureField("비밀번호 입력", text: $password)
                                .padding(15)
                                .font(Font.custom("S-Core Dream", size: 10))
                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                .cornerRadius(20)
                                .padding(.horizontal, 32)
                                .padding(.top, -10)
                            Button {
                                print("eye click")

                                passwordMasking = false
                            } label: {
                                Image(systemName: "eye")
                                    .foregroundColor(CustomColors.gray06)
                               
                                
                            }
                            .offset(x : 130 , y: -3)
                        }
                    }
                    else{
                        ZStack{
                            TextField("비밀번호 입력", text: $password)
                                .padding(15)
                                .font(Font.custom("S-Core Dream", size: 10))
                                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                                .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                                .cornerRadius(20)
                                .padding(.horizontal, 32)
                                .padding(.top, -10)
                            Button {
                                print("eye click")
                                passwordMasking = true
                            } label: {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(CustomColors.gray06)
                                   
                                
                            }
                            .offset(x: 130, y: -3)
                        }
                    }
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            print("autologin_on")
                        } label: {
                            Image(systemName: "circle")
                                .foregroundColor(CustomColors.gray05
                                )
                        }
                        
                        Text ("자동 로그인")
                            .font(Font.custom("S-Core Dream", size: 8))
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                        
                        Spacer()
                        
                        Button {
                            print("id Finding")
                        } label: {
                            Text("아이디 찾기")
                                .font(Font.custom("S-Core Dream", size: 8))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
                        }
                        Button {
                            print("pw Finding")
                        } label: {
                            Text("비밀번호 찾기")
                                .font(Font.custom("S-Core Dream", size: 8))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
                        }
                        
                    }//hstack end
                    .padding(.horizontal, 32)
                    
                    Spacer()
                    
                    Button {
                        print("login button")
                        Task{
                            await userStateViewModel.signIn(email: id, password: password)
                            if(userStateViewModel.isLoggedIn == true){
                                isActive = true
                            }
                        }
                    } label: {
                        if loginButtonEnable {
                            Text("로그인")
                                .modifier(LoginButtonModifier())
                                .padding(.horizontal)
                        } else {
                            Text("로그인")
                                .modifier(LoginButtonModifier2())
                                .padding(.horizontal)
                        }
                    }
                    .disabled(id.isEmpty || password.isEmpty)
                    .onChange(of: id) { _ in
                        updateLoginButtonEnable()
                    }
                    .onChange(of: password) { _ in
                        updateLoginButtonEnable()
                    }

                    Spacer()
                    HStack{
                        Spacer()
                        Text("계정이 존재하지 않는다면?")
                            .font(Font.custom("S-Core Dream", size: 10))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                        Button {
                            print("회원가입 버튼")
                        } label: {
                            Text("회원가입하기")
                                .font(Font.custom("S-Core Dream", size: 10))
                                .multilineTextAlignment(.center)
                                .foregroundColor(CustomColors.primary06)
                        }
                        Spacer()
                    } //hstack end
                    .padding(.bottom, 50)
                    Spacer()
                }//vstack end
                .frame(width:393, height: 532)
                .background(.white)
                .cornerRadius(24)
                .offset(y:150)
            }
        }//navi end
        .navigationBarBackButtonHidden(true)
    }//body end
    
} //로그인뷰 끝

struct LoginButtonModifier: ViewModifier {
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
struct LoginButtonModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity) // 너비를 최대로 설정
                            .padding() // 내부 여백
                            .frame(height: 40) // 높이 설정
                            .background(CustomColors.gray04) // 배경 색상
                            .foregroundColor(.white) // 글자 색상
                            .cornerRadius(10) // 모서리를 둥글게
                            .font(Font.custom("S-CoreDream-5Medium", size: 14))
    }
}


#Preview {
    LoginView()
}
