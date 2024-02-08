//
//  SearchViewModel.swift
//  Honzapda
//
//  Created by 황주연 on 2/3/24.
//

import Foundation
import SwiftUI

struct Shop: Codable, Identifiable {
    let shopId: Int
    let shopName: String
    let address: String
    let address_spec: String
    let openNow: Bool
    let photoUrl: String?

    var id: Int {
        return shopId
    }
}

struct Pageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [String]
    let offset: Int
    let unpaged: Bool
    let paged: Bool
    let total: Int
    let numberOfElements: Int
    let first: Bool
    let last: Bool
}

class ShopViewModel: ObservableObject {
    @Published var shops: [Shop]
    
    init(shops: [Shop] = []) {
        self.shops = shops
    }
}


struct SearchDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var searchText: String = ""
    @State private var isEditing: Bool = false
    @ObservedObject var shopViewModel: ShopViewModel
    init(shopViewModel: ShopViewModel) {
            self.shopViewModel = shopViewModel
            self.shopViewModel.shops = [
                Shop(shopId: 1, shopName: "스테이 어도러블", address: "경기 용인시 기흥구 죽전로43번길 15-3 1층", address_spec: "Spec 1", openNow: true, photoUrl: "cafe1"),
                
                Shop(shopId: 2, shopName: "스테이 어도루블", address: "경기 용인시 기흥구 죽전로43번길 15-3 1층", address_spec: "Spec 2", openNow: false, photoUrl: "cafe2"),
                
                Shop(shopId: 3, shopName: "스테이 어도리블", address: "경기 용인시 기흥구 죽전로43번길 15-3 1층", address_spec: "Spec 3", openNow: true, photoUrl: "cafe1")
            ]
        }
    
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
        ZStack{
            Image("Background_selected_search")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack{
                VStack{
                    HStack {
                        backButton.padding(.leading, 16)
                        
                        // 수정필요
                        Text("스테이").font(.custom("S-CoreDream-5Medium", size: 12)).foregroundColor(CustomColors.gray09).padding(.leading, 8)
                        
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
//                                searchTitlesManager.addSearchTitle(searchText)
                            }) {
                                Image("icon_search_search_fill")
                            }
                            .padding(.leading, 255)
                        }
                    }.background(.white)
                        .onTapGesture {
                            self.isEditing = true
                        }
                    
                    Divider()
                    
                    HStack{
                        Button(action: {
                            print("전체 3")
                        }) {
                            Text("전체 3")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                .foregroundColor(.white)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(CustomColors.primary05)
                                    .stroke(CustomColors.primary05, lineWidth: 1.3))
                        }
                        .padding(.leading, 10)
                        
                        Button(action: {
                            print("거리순")
                        }) {
                            Text("거리순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .stroke(CustomColors.primary05, lineWidth: 1.3))
                        }.padding(3)
                        Button(action: {
                            print("리뷰순")
                        }) {
                            Text("리뷰순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .stroke(CustomColors.primary05, lineWidth: 1.3))
                        }.padding(3)
                        Button(action: {
                            print("저장순")
                        }) {
                            Text("저장순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .stroke(CustomColors.primary05, lineWidth: 1.3))
                        }.padding(3)
                        Button(action: {
                            print("추천순")
                        }) {
                            Text("추천순")
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                                .foregroundColor(CustomColors.primary05)
                                .font(.custom("S-CoreDream-5Medium", size: 10))
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .stroke(CustomColors.primary05, lineWidth: 1.3))
                        }.padding(3)
                        
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width).background(.white)
                        .padding(.bottom, 8)
                }.background(Color.white)
                
                Spacer()
                
                ShopListView(shopViewModel: shopViewModel)
                
                
            }.frame(height: UIScreen.main.bounds.height-115)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchDetailView(shopViewModel: ShopViewModel())
}


struct ShopListView: View {
    @ObservedObject var shopViewModel: ShopViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(shopViewModel.shops) { shop in
                        NavigationLink(
                            // 상세뷰로 이동
                            destination: SearchView()) {
                                CardView(shop: shop)
                                    .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(8)
                }
            }
        }
    }
}

struct CardView: View {
    var shop: Shop

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                if let photoUrl = shop.photoUrl {
                    Image(photoUrl)
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

struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleShops = [
            Shop(shopId: 1, shopName: "스테이 어도러블", address: "경기 용인시 기흥구 죽전로43번길 15-3 1층", address_spec: "Spec 1", openNow: true, photoUrl: "cafe1"),
            
            Shop(shopId: 2, shopName: "스테이 어도루블", address: "경기 용인시 기흥구 죽전로43번길 15-3 1층", address_spec: "Spec 2", openNow: false, photoUrl: "cafe2"),
            
            Shop(shopId: 3, shopName: "스테이 어도리블", address: "경기 용인시 기흥구 죽전로43번길 15-3 1층", address_spec: "Spec 3", openNow: true, photoUrl: "cafe1")
        ]

        let viewModel = ShopViewModel(shops: sampleShops)

        return ShopListView(shopViewModel: viewModel)
    }
}
