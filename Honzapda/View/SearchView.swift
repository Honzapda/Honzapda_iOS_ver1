import Foundation
import SwiftUI

struct SearchView: View{
    @StateObject private var searchTitlesManager = SearchTitlesManager()
    @State private var searchText: String = ""
    @State private var isEditButtonEnabled: Bool = true
    @State private var isSearchResultViewPresented = false
    @EnvironmentObject var shopViewModel: ShopViewModel
    @State private var isSearchDetailViewActive = false

    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack{
                    Image("Background_search").resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    VStack(alignment: .leading) {
                        Image("logo_navigationbar").padding(EdgeInsets(top: 12, leading: 16, bottom: 8, trailing: 0))
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 7) {
                            Text("\(Text("검색어").font(.custom("S-CoreDream-6Bold", size: 24)).foregroundColor(CustomColors.primary06))\(Text("를").font(.custom("S-CoreDream-5Medium", size: 24)).foregroundColor(CustomColors.primary06))")
                            
                            Text("\(Text("입력").font(.custom("S-CoreDream-6Bold", size: 24)).foregroundColor(CustomColors.primary06))\(Text("해주세요").font(.custom("S-CoreDream-5Medium", size: 24)).foregroundColor(CustomColors.primary06))")
                        }.padding(EdgeInsets(top: 76, leading: 24, bottom: 48, trailing: 0))
                        
                        
                        ZStack(alignment: .leading) {
                            HStack {
                                Button(action: {
                                    isSearchResultViewPresented.toggle()
                                    print("검색")
                                }) {
                                    Text("카페명, 주소명으로 검색").font(.custom("S-CoreDream-5Medium", size: 12)).padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 0))
                                        .foregroundColor(CustomColors.primary04)
                                    
                                    Spacer()
                                    Image("icon_search_search_fill").padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 24))
                                    
                                }
                                .accentColor(CustomColors.primary04)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(CustomColors.primary05, lineWidth: 1.5)
                                        .background(Color.white)
                                )
                            }
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 40, trailing: 24))
                        }.background(
                            NavigationLink(
                                destination: SearchResultView(searchTitlesManager: searchTitlesManager),
                                isActive: $isSearchResultViewPresented
                            ) {
                                EmptyView().hidden()
                            }).navigationBarHidden(true)
                        
                        HStack{
                            Text("최근 검색어").font(.custom("S-CoreDream-6Bold", size: 18)).foregroundColor(CustomColors.primary06).padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                            Button(action: {
                                isEditButtonEnabled.toggle()
                            }) {
                                isEditButtonEnabled ?
                                Text("편집").font(.custom("S-CoreDream-5Medium", size: 10)).foregroundColor(CustomColors.primary02) : Text("확인").font(.custom("S-CoreDream-5Medium", size: 10)).foregroundColor(CustomColors.primary02)
                            }
                        }
                        
                        NavigationLink(destination: SearchDetailView(searchText: $searchText, shopViewModel: _shopViewModel, searchTitlesManager: searchTitlesManager), isActive: $isSearchDetailViewActive) {
                            EmptyView()
                        }.navigationBarHidden(true)
                        
                        if isEditButtonEnabled {
                            HStack {
                                VStack (alignment: .leading){
                                    ForEach(searchTitlesManager.getSearchTitles(), id: \.self) { title in
                                        Button(action: {
                                            print("검색어: \(title)")
                                            searchText = title
                                            isSearchDetailViewActive = true
                                            ShopViewModel.searchShops(with: title, latitude: "37.520417", longitude: "126.887784", page: 0, size: 10, sortColumn: "all", distance: 2) { result in
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
                                            Text(title)
                                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                                .foregroundColor(CustomColors.primary03)
                                                .font(.custom("S-CoreDream-5Medium", size: 12))
                                                .frame(height: 34)
                                                .background(RoundedRectangle(cornerRadius: 24)
                                                    .stroke(CustomColors.primary04, lineWidth: 1.3))
                                        }
                                        .padding(EdgeInsets(top: 10, leading: 24, bottom: 0, trailing: 4))
                                    }
                                }
                            }
                        }
                        else{
                            HStack {
                                VStack (alignment: .leading){
                                    ForEach(searchTitlesManager.getSearchTitles(), id: \.self) { title in
                                        Button(action: {
                                            print("검색어: \(title)")
                                        }) {
                                            HStack {
                                                Button(action: {
                                                    print("삭제")
                                                    searchTitlesManager.deleteSearchTitle(title)
                                                }) {
                                                    Image("icon_search_xbutton_fill")
                                                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                                                }
                                                Text(title)
                                                    .foregroundColor(CustomColors.primary03)
                                                    .font(.custom("S-CoreDream-5Medium", size: 12))
                                                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 20))
                                                    .frame(height: 34)
                                            }
                                        }
                                        .background(RoundedRectangle(cornerRadius:  24)
                                            .stroke(CustomColors.primary04, lineWidth: 1.3))
                                        .padding(EdgeInsets(top: 10, leading: 24, bottom: 0, trailing: 4))
                                    }
                                }
                            }
                        }
                        
                    }.offset(y: -geometry.size.height * (0.26 - 0.0345 * Double(searchTitlesManager.getSearchTitles().count)))
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
