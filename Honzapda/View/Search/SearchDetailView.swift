import Foundation
import SwiftUI
import URLImage

struct SearchDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    @State private var isEditing: Bool = false
    @EnvironmentObject var shopViewModel: ShopViewModel
    @StateObject var searchTitlesManager: SearchTitlesManager
    @State private var sortColumn: String = "all"
    
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
            ZStack{
                Image("Background_selected_search")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack{
                    VStack{
                        HStack {
                            backButton.padding(.leading, 16)
                            
                            TextField("", text: $searchText, onEditingChanged: { editing in
                                self.isEditing = editing
                            })
                            .frame(height: 45)
                            .foregroundColor(CustomColors.primary04)
                            .font(.custom("S-CoreDream-5Medium", size: 12))
                            .accentColor(CustomColors.primary04)
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            .overlay {
                                Button(action: {
                                    searchTitlesManager.addSearchTitle(searchText)
                                    ShopViewModel.searchShops(with: searchText, latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: sortColumn, distance: 2) { result in
                                        switch result {
                                        case .success(let shops):
                                            DispatchQueue.main.async {
                                                shopViewModel.shops = shops
                                            }
                                        case .failure(let error):
                                            print("Error: \(error.localizedDescription)")
                                        }
                                    }
                                }) {
                                    Image("icon_search_search_fill")
                                }
                                .padding(.leading, 300)
                            }
                        }.background(.white)
                            .onTapGesture {
                                self.isEditing = true
                            }
                        
                        Divider()
                        
                        HStack{
                            Button(action: {
                                sortColumn = "all"
                                print(sortColumn)
                            }) {
                                Text("전체 \(String(shopViewModel.shops.count))")
                                    .lineLimit(1)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .foregroundColor(.white)
                                    .font(.custom("S-CoreDream-5Medium", size: 10))
                                    .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(CustomColors.primary05)
                                        .border(CustomColors.primary05, width: 1.3))
                            }
                            .padding(.leading, 10)
                            
                            Button(action: {
                                sortColumn = "distance"
                                print(sortColumn)
                                ShopViewModel.searchShops(with: searchText, latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: sortColumn, distance: 2) { result in
                                    switch result {
                                    case .success(let shops):
                                        DispatchQueue.main.async {
                                            shopViewModel.shops = shops
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
                            }.padding(3)
                            Button(action: {
                                sortColumn = "review"
                                print(sortColumn)
                                ShopViewModel.searchShops(with: searchText, latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: sortColumn, distance: 2) { result in
                                    switch result {
                                    case .success(let shops):
                                        DispatchQueue.main.async {
                                            shopViewModel.shops = shops
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
                                ShopViewModel.searchShops(with: searchText, latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: sortColumn, distance: 2) { result in
                                    switch result {
                                    case .success(let shops):
                                        DispatchQueue.main.async {
                                            shopViewModel.shops = shops
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
                                ShopViewModel.searchShops(with: searchText, latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: sortColumn, distance: 2) { result in
                                    switch result {
                                    case .success(let shops):
                                        DispatchQueue.main.async {
                                            shopViewModel.shops = shops
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
                  
                    if shopViewModel.shops.count == 0{
                        Text("검색 결과가 없어요 :(")
                            .foregroundColor(CustomColors.gray05)
                            .font(.custom("S-CoreDream-5Medium", size: 12))
                        Spacer()
                    }
                    else{
                 ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(shopViewModel.shops) { shop in
                                // 상세 뷰로 이동
                                NavigationLink(
                                    destination: ShopDetailView(shopId: shop.shopId)
                                ) {
                                    ShopCardView(shop: shop)
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .padding(8)
                        }
                    }
                    
                }.frame(height: UIScreen.main.bounds.height-115)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ShopCardView: View {
    var shop: SearchShop

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                
                URLImage(URL(string: shop.photoUrl)!) { image in
                    image
                        .resizable()
                        .frame(width: 345, height: 160)
                        .clipped()
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
                    Text(shop.address)
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
