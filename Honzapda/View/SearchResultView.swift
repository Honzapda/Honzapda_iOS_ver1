//
//  SearchResultView.swift
//  Honzapda
//
//  Created by 황주연 on 1/25/24.
//

import Foundation
import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) var dismiss
    @State var searchText: String = ""
    @State private var isEditing: Bool = false
    @StateObject var searchTitlesManager: SearchTitlesManager
    @State private var isSearchViewPresented = false
    
    
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
                HStack {
                    backButton.padding(.leading, 16)
                    TextField("카페명, 주소명으로 검색", text: $searchText, onEditingChanged: { editing in
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
                            isSearchViewPresented = true
                            
                        }) {
                            Image("icon_search_search_fill")
                        }
                        .background(
                            NavigationLink(
                                destination: SearchDetailView(shopViewModel: ShopViewModel()),
                                isActive: $isSearchViewPresented
                            ) {
                                EmptyView().hidden()
                            })
                        .padding(.leading, 300)
                    }
                }.background(.white)
                
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .padding(.top, 10)
                Spacer()
                Text("검색어를 입력해주세요!").font(.custom("S-CoreDream-5Medium", size: 12)).foregroundColor(CustomColors.gray05)
                Spacer()
            }.frame(height: UIScreen.main.bounds.height-110) // 115
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView()
}


import Foundation
import Combine

class SearchTitlesManager: ObservableObject {
    @Published private var searchTitles: [String] = []

    init() {
        self.searchTitles = UserDefaults.standard.stringArray(forKey: "searchTitles") ?? []
        print("Initialized searchTitles with: \(searchTitles)")
    }
    
    func setSearchTitles(_ searchTitles: [String]){
        self.searchTitles = searchTitles
    }
    
    func getSearchTitles() -> [String] {
        return self.searchTitles
    }

    func updateSearchTitles(_ newTitles: [String]) {
    }
     
    func deleteSearchTitle(_ title: String) {
        if let index = searchTitles.firstIndex(of: title){
            searchTitles.remove(at: index)
        }
        UserDefaults.standard.set(searchTitles, forKey: "searchTitles")
        UserDefaults.standard.synchronize()
    }
    
    func addSearchTitle(_ title: String) {
        if searchTitles.contains(title) {
            deleteSearchTitle(title)
        }
        searchTitles.insert(title, at: 0)
        if searchTitles.count > 5 {
            searchTitles = Array(searchTitles.prefix(5))
        }
        UserDefaults.standard.set(searchTitles, forKey: "searchTitles")
        UserDefaults.standard.synchronize()
        print(title)
        print(searchTitles.count)
        
    }
}