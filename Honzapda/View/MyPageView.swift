import Foundation
import SwiftUI
import URLImage

struct MyPageView: View {
    @State private var isToggle: Bool = true
    @State private var isCafeTasteViewActive = false
    @EnvironmentObject var myProfileViewModel: MyProfileViewModel
    @State private var profileImage: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    Image("logo_navigationbar").padding(EdgeInsets(top: 12, leading: 16, bottom: 8, trailing: 0))
                    Divider()
                    CustomColors.white.frame(height: 160)
                }
                
                ZStack{
                    CustomColors.gray01.frame(maxHeight: .infinity)
                    VStack {
                        ZStack{
                            Circle()
                                .frame(width: 97, height: 97)
                                .overlay(
                                    URLImage(URL(string: profileImage ? myProfileViewModel.profileImage : "image_my_profile_none")!) { image in image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 97, height: 97)
                                            .clipShape(Circle())
                                    }
                                )
                            Button(action: {
                                print("프로필 사진 변경") // 안눌림
                            }) {
                                Image("icon_my_plus_fill").offset(x: 30, y: 30)
                            }
                        }.offset(y: -49)
                        
                        Text(myProfileViewModel.name)
                            .font(.custom("S-CoreDream-6Bold", size: 20))
                            .foregroundStyle(CustomColors.primary06)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 22, trailing: 0))
                            .offset(y: -49)
                        
                        
                        // 카페 취향 카드뷰
                        VStack {
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("나만의 카페 취향")
                                            .foregroundColor(CustomColors.gray10)
                                            .font(.custom("S-CoreDream-6Bold", size: 16))
                                        Spacer()
                                        NavigationLink(destination: MyPageCafeTasteView()) {
                                            Text("수정")
                                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                                .foregroundColor(CustomColors.gray05)
                                        }
                                    }.padding(.bottom, 7)
                                    
                                    Text("카페 취향은 큐레이션 시 사용되며, 언제든지 변경할 수 있어요!")
                                        .font(.custom("S-CoreDream-5Medium", size: 8))
                                        .foregroundColor(CustomColors.gray07)
                                        .padding(.bottom, 10)
                                    
                                    ScrollView(.horizontal) {
                                        HStack{
                                            ForEach(myProfileViewModel.preferNameList, id: \.self) { preferName in
                                                
                                                Button(action: {
                                                }) {
                                                    Text(preferName)
                                                        .font(.custom("S-CoreDream-5Medium", size: 10))
                                                        .foregroundColor(CustomColors.white)
                                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 24)
                                                                .fill(CustomColors.primary05))
                                                }
                                            }
                                        }
                                    }
                                }.padding(24)
                            }
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                        .padding(EdgeInsets(top: -50, leading: 16, bottom: 20, trailing: 16))
                        
                        // 찜한 카페 카드뷰
                        VStack {
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("내가 찜한 카페")
                                            .foregroundColor(CustomColors.gray10)
                                            .font(.custom("S-CoreDream-6Bold", size: 16))
                                        
                                        // 디테일뷰로 이동
                                        NavigationLink(destination: MyPageSavedCafeView()) {
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .frame(width: 4, height: 7)
                                                .foregroundColor(.black)
                                        }
                                    }.padding(.bottom, 7)
                                    
                                    Text("내가 찜한 카페 리스트를 확인할 수 있어요.")
                                        .font(.custom("S-CoreDream-5Medium", size: 8))
                                        .foregroundColor(CustomColors.gray07)
                                        .padding(.bottom, 10)
                                    
                                    ScrollView(.horizontal) {
                                        HStack{
                                            ForEach(myProfileViewModel.likeShops, id: \.shopId) { likeshop in
                                                ZStack(alignment: .bottomLeading) {
                                                    URLImage(URL(string: likeshop.shopMainImage)!) { image in image
                                                            .resizable()
                                                            .frame(width: 102, height: 144)
                                                    }
                                                    Text("\(likeshop.shopName)")
                                                        .font(.custom("S-CoreDream-6Bold", size: 10))
                                                        .foregroundColor(CustomColors.white)
                                                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 8, trailing: 0))
                                                }
                                                .background(Color.white)
                                                .cornerRadius(12)
                                            }
                                        }
                                    }
                                }.padding(24)
                            }
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
                        
                        CustomColors.gray03.frame(height: 8)
                        VStack(alignment: .leading){
                            Text("설정")
                                .font(.custom("S-CoreDream-6Bold", size: 18))
                                .foregroundStyle(CustomColors.gray10)
                                .padding(EdgeInsets(top: 24, leading: 24, bottom: 32, trailing: 0))
                            HStack{
                                Text("푸시 알림 설정")
                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                    .foregroundStyle(CustomColors.gray10)
                                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                                Toggle("", isOn: $isToggle)
                                    .padding(.trailing, 26) .toggleStyle(SwitchToggleStyle(tint: CustomColors.primary05)).frame(height: 17)
                            }
                            Divider().padding(16).foregroundColor(CustomColors.gray03)
                            
                            Button(action: {
                                print("도움말")
                            }) {
                                Text("도움말")
                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                    .foregroundStyle(CustomColors.gray10)
                                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                            }
                            Divider().padding(16).foregroundColor(CustomColors.gray03)
                            
                            Button(action: {
                                print("로그아웃")
                            }) {
                                Text("로그아웃")
                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                    .foregroundStyle(CustomColors.gray10)
                                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                            }
                            Divider().padding(16).foregroundColor(CustomColors.gray03)
                            
                            Button(action: {
                                print("서비스 탈퇴")
                            }) {
                                Text("서비스 탈퇴")
                                    .font(.custom("S-CoreDream-5Medium", size: 14))
                                    .foregroundStyle(CustomColors.gray10)
                                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                            }
                            Divider().padding(16).foregroundColor(CustomColors.gray03)
                        }.padding(.bottom, 48)
                    }
                }
                
            }
        }
        .onAppear(){
            MyProfileViewModel.CheckMyProfile { result in
                switch result {
                case .success(let profileResult):
                    DispatchQueue.main.async {
                        myProfileViewModel.likeShops = profileResult.likeShops
                        myProfileViewModel.preferNameList = profileResult.preferNameList
                        myProfileViewModel.profileImage = profileResult.profileImage
                        myProfileViewModel.name = profileResult.name
                        profileImage = true
                        print("DDDD----")
                        print(profileImage)
                        print(myProfileViewModel.profileImage)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
    //
    //    struct CafeTasteCardView: View {
    //        @State private var isCafeTasteViewActive = false
    //
    //        var body: some View {
    //            NavigationView{
    //
    //                VStack {
    //                    VStack(alignment: .leading, spacing: 16) {
    //
    //                        VStack(alignment: .leading){
    //                            HStack{
    //                                Text("나만의 카페 취향")
    //                                    .foregroundColor(CustomColors.gray10)
    //                                    .font(.custom("S-CoreDream-6Bold", size: 16))
    //                                Spacer()
    //                                NavigationLink(destination: CafeTasteView()) {
    //                                    Text("수정")
    //                                        .font(.custom("S-CoreDream-5Medium", size: 10))
    //                                        .foregroundColor(CustomColors.gray05)
    //                                }
    //                            }.padding(.bottom, 7)
    //
    //                            Text("카페 취향은 큐레이션 시 사용되며, 언제든지 변경할 수 있어요!")
    //                                .font(.custom("S-CoreDream-5Medium", size: 8))
    //                                .foregroundColor(CustomColors.gray07)
    //                                .padding(.bottom, 10)
    //
    //                            ScrollView(.horizontal) {
    //                                HStack{
    //                                    Button(action: {}) {
    //                                        Text("깨끗한")
    //                                            .font(.custom("S-CoreDream-5Medium", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    //                                            .background(
    //                                                RoundedRectangle(cornerRadius: 24)
    //                                                    .fill(CustomColors.primary05))
    //                                    }
    //
    //                                    Button(action: {}) {
    //                                        Text("깨끗한")
    //                                            .font(.custom("S-CoreDream-5Medium", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    //                                            .background(
    //                                                RoundedRectangle(cornerRadius: 24)
    //                                                    .fill(CustomColors.primary05))
    //                                    }
    //                                    Button(action: {}) {
    //                                        Text("깨끗한")
    //                                            .font(.custom("S-CoreDream-5Medium", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    //                                            .background(
    //                                                RoundedRectangle(cornerRadius: 24)
    //                                                    .fill(CustomColors.primary05))
    //                                    }
    //
    //                                    Button(action: {}) {
    //                                        Text("깨끗한")
    //                                            .font(.custom("S-CoreDream-5Medium", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    //                                            .background(
    //                                                RoundedRectangle(cornerRadius: 24)
    //                                                    .fill(CustomColors.primary05))
    //                                    }
    //                                }
    //                            }
    //                        }.padding(24)
    //                    }
    //                    .background(Color.white)
    //                    .cornerRadius(16)
    //                    .shadow(radius: 2)
    //                }
    //                .padding(EdgeInsets(top: 22, leading: 16, bottom: 24, trailing: 16))
    //            }
    //        }
    //    }
    //
    //    struct LoveCafeCardView: View {
    //        var body: some View {
    //            NavigationView{
    //
    //                VStack {
    //                    VStack(alignment: .leading, spacing: 16) {
    //                        VStack(alignment: .leading){
    //                            HStack{
    //                                Text("내가 찜한 카페")
    //                                    .foregroundColor(CustomColors.gray10)
    //                                    .font(.custom("S-CoreDream-6Bold", size: 16))
    //                                // 디테일뷰로 이동
    //                                NavigationLink(destination: CafeTasteView()) {
    //                                    Image(systemName: "chevron.right")
    //                                        .resizable()
    //                                        .frame(width: 4, height: 7)
    //                                        .foregroundColor(.black)
    //                                }
    //                            }.padding(.bottom, 7)
    //
    //                            Text("내가 찜한 카페 리스트를 확인할 수 있어요.")
    //                                .font(.custom("S-CoreDream-5Medium", size: 8))
    //                                .foregroundColor(CustomColors.gray07)
    //                                .padding(.bottom, 10)
    //
    //                            ScrollView(.horizontal) {
    //                                HStack{
    //
    //                                    ZStack(alignment: .bottomLeading) {
    //                                        Image("cafe1")
    //                                            .resizable()
    //                                            .frame(width: 102, height: 144)
    //                                        Text("필아웃커피 보정점")
    //                                            .font(.custom("S-CoreDream-6Bold", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 8, trailing: 0))
    //                                    }
    //                                    .background(Color.white)
    //                                    .cornerRadius(12)
    //
    //                                    ZStack(alignment: .bottomLeading) {
    //                                        Image("cafe1")
    //                                            .resizable()
    //                                            .frame(width: 102, height: 144)
    //                                        Text("필아웃커피 보정점")
    //                                            .font(.custom("S-CoreDream-6Bold", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 8, trailing: 0))
    //                                    }
    //                                    .background(Color.white)
    //                                    .cornerRadius(12)
    //
    //                                    ZStack(alignment: .bottomLeading) {
    //                                        Image("cafe1")
    //                                            .resizable()
    //                                            .frame(width: 102, height: 144)
    //                                        Text("필아웃커피 보정점")
    //                                            .font(.custom("S-CoreDream-6Bold", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 8, trailing: 0))
    //                                    }
    //                                    .background(Color.white)
    //                                    .cornerRadius(12)
    //
    //                                    ZStack(alignment: .bottomLeading) {
    //                                        Image("cafe1")
    //                                            .resizable()
    //                                            .frame(width: 102, height: 144)
    //                                        Text("필아웃커피 보정점")
    //                                            .font(.custom("S-CoreDream-6Bold", size: 10))
    //                                            .foregroundColor(CustomColors.white)
    //                                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 8, trailing: 0))
    //                                    }
    //                                    .background(Color.white)
    //                                    .cornerRadius(12)
    //                                }
    //                            }
    //                        }.padding(24)
    //                    }
    //                    .background(Color.white)
    //                    .cornerRadius(16)
    //                    .shadow(radius: 2)
    //                }
    //                .padding(EdgeInsets(top: 22, leading: 16, bottom: 24, trailing: 16))
    //            }
    //        }
    //    }
    //}
    //
    //
    //struct ImageCardView: View {
    //    var body: some View {
    //        ZStack(alignment: .bottomLeading) {
    //            Image("cafe1")
    //                .resizable()
    //                .frame(width: 102, height: 144)
    //            Text("필아웃커피 보정점")
    //                .font(.custom("S-CoreDream-6Bold", size: 10))
    //                .foregroundColor(CustomColors.white)
    //                .padding(EdgeInsets(top: 0, leading: 6, bottom: 8, trailing: 0))
    //        }
    //        .background(Color.white)
    //        .cornerRadius(12)
    //    }
    //}
    
    struct MyPageView_Preview: PreviewProvider{
        static var previews: some View{
            return MyPageView()
        }
    }
    
    //struct ImageCardView_Preview: PreviewProvider{
    //    static var previews: some View{
    //        return ImageCardView()
    //    }
    //}
    //
    //
    //struct LoveCafeView_Preview: PreviewProvider{
    //    static var previews: some View{
    //        return LoveCafeCardView()
    //    }
    //}
    //
    //struct CafeTasteCardView_Preview: PreviewProvider{
    //    static var previews: some View{
    //        return CafeTasteCardView()
    //    }
    //}
    
    
    //// api 받아온 값 보여주기
    //struct ContentView: View {
    //    @State private var apiResponse: ApiResponse?
    //    @State private var errorMessage: String?
    //
    //    var body: some View {
    //        VStack {
    //            if let response = apiResponse {
    //                Text("Name: \(response.result.name)")
    //                Text("Profile Image: \(response.result.profileImage)")
    //                Text("Prefer Name List: \(response.result.preferNameList.joined(separator: ", "))")
    //                ForEach(response.result.likeShops, id: \.shopId) { shop in
    //                    Text("Shop Name: \(shop.shopName), Shop ID: \(shop.shopId)")
    //                }
    //            } else if let errorMessage = errorMessage {
    //                Text("Error: \(errorMessage)")
    //            } else {
    //                Text("Loading...")
    //            }
    //        }
    //        .onAppear {
    //            ApiClient().fetchUserData { result in
    //                switch result {
    //                case .success(let response):
    //                    self.apiResponse = response
    //                case .failure(let error):
    //                    self.errorMessage = error.localizedDescription
    //                }
    //            }
    //        }
    //    }
    //}
    //
    //struct ContentView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ContentView()
    //    }
    //}
