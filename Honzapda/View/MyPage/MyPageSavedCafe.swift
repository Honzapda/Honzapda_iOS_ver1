import Foundation
import SwiftUI
import URLImage

struct MyPageSavedCafeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var sortColumn: String = ""
    @EnvironmentObject var myProfileViewModel: MyProfileViewModel
    @EnvironmentObject var shopViewModel: ShopViewModel
    @EnvironmentObject var savedCafeViewModel: SavedCafeViewModel
    
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{}.padding()
                VStack(alignment: .leading){
                    backButton.padding(EdgeInsets(top: 0, leading: 16, bottom: 5, trailing: 0))
                    Divider()
                    
                    Text("\(myProfileViewModel.likeShops.count)개의 찜한 카페")
                        .foregroundColor(CustomColors.primary06)
                        .font(.custom("S-CoreDream-6Bold", size: 12))
                        .padding(EdgeInsets(top: 16, leading: 24, bottom: 2, trailing: 0))
                    
                    HStack{
                        Button(action: {
                            sortColumn = "distance"
                            print(sortColumn)
                            SavedCafeViewModel.getSavedCafeList() { result in
                                switch result {
                                case .success(let shops):
                                    DispatchQueue.main.async {
                                        savedCafeViewModel.shops = shops
                                    }
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Text("거리순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(sortColumn == "distance" ? CustomColors.white : CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(sortColumn == "distance" ? CustomColors.primary05 : CustomColors.white)
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(CustomColors.primary05, lineWidth: 1.3)))
                        }.padding(.leading, 24)
                        Button(action: {
                            sortColumn = "review"
                            print(sortColumn)
                            SavedCafeViewModel.getSavedCafeList() { result in
                                switch result {
                                case .success(let shops):
                                    DispatchQueue.main.async {
                                        savedCafeViewModel.shops = shops
                                    }
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Text("리뷰순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(sortColumn == "review" ? CustomColors.white : CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(sortColumn == "review" ? CustomColors.primary05 : CustomColors.white)
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(CustomColors.primary05, lineWidth: 1.3)))
                        }.padding(3)
                        Button(action: {
                            sortColumn = "bookmark"
                            print(sortColumn)
                            SavedCafeViewModel.getSavedCafeList() { result in
                                switch result {
                                case .success(let shops):
                                    DispatchQueue.main.async {
                                        savedCafeViewModel.shops = shops
                                    }
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Text("저장순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(sortColumn == "bookmark" ? CustomColors.white : CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(sortColumn == "bookmark" ? CustomColors.primary05 : CustomColors.white)
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(CustomColors.primary05, lineWidth: 1.3)))
                        }.padding(3)
                        Button(action: {
                            sortColumn = "recommend"
                            print(sortColumn)
                            SavedCafeViewModel.getSavedCafeList() { result in
                                switch result {
                                case .success(let shops):
                                    DispatchQueue.main.async {
                                        savedCafeViewModel.shops = shops
                                    }
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Text("추천순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(sortColumn == "recommend" ? CustomColors.white : CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(sortColumn == "recommend" ? CustomColors.primary05 : CustomColors.white)
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(CustomColors.primary05, lineWidth: 1.3)))
                        }.padding(3)
                        
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width).background(.white)
                        .padding(.bottom, 8)
                }.background(Color.white)
                
                Spacer()
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(savedCafeViewModel.shops) { shop in
                            // 상세 뷰로 이동
                            NavigationLink(
                                destination: ShopDetailView(shopId: shop.shopId)
                            ) {
                                SavedCafeCardView(shop: shop)
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(8)
                    }
                }
            }.frame(height: UIScreen.main.bounds.height-115)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            MyProfileViewModel.CheckMyProfile { result in
                switch result {
                case .success(let profileResult):
                    DispatchQueue.main.async {
                        myProfileViewModel.likeShops = profileResult.likeShops
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            ShopViewModel.searchShops(with: "S", latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: "all", distance: 2) { result in
                switch result {
                case .success(let shops):
                    DispatchQueue.main.async {
                        shopViewModel.shops = shops
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            SavedCafeViewModel.getSavedCafeList() { result in
                switch result {
                case .success(let shops):
                    DispatchQueue.main.async {
                        savedCafeViewModel.shops = shops
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    struct SavedCafeCardView: View {
        var shop: SavedCafeResult
        
        var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack{
                        URLImage(URL(string: shop.mainImage)!) { image in
                            image
                                .resizable()
                                .frame(width: 345, height: 160)
                                .clipped()
                        }
                        VStack(){
                            Spacer()
                            HStack{
                                Spacer()
                                VStack{
                                    Image("icon_my_heart_fill")
                                    Text("가게 찜")
                                        .foregroundColor(CustomColors.white)
                                        .font(.custom("S-CoreDream-5Medium", size: 4))
                                }.padding(10)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8){
                        HStack{
                            Text(shop.shopName)
                                .foregroundColor(CustomColors.gray10).font(.custom("S-CoreDream-6Bold", size: 14))
                            
                            Text(shop.openNow ? "영업 중" : "휴무")
                                .font(.custom("S-CoreDream-3Light", size: 6))
                                .padding(4)
                                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.5))
                                .foregroundColor(CustomColors.gray08)
                        }
                        Text(shop.address_spec)
                            .font(.custom("S-CoreDream-5Medium", size: 8))
                            .foregroundColor(CustomColors.gray07)
                            .padding(.bottom, 24)
                    }.padding(.leading, 24)
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
            }
            .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
        }
    }
}

#Preview {
    MyPageSavedCafeView()
}

