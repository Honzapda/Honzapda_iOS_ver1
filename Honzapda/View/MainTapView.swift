//
//  MainTapView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/17.
//

import Foundation
import SwiftUI
import UIKit

struct MainTapView: View{
    
    @State private var selected: Int = 0
    
    var body:some View{
        TabView{
            HomeView()
                .tabItem {
                        Image("tabview_home_unselected")
                            .renderingMode(.template)
                        Text("홈")
                }
                
            SearchView()
                .tabItem {
                    Image("tabview_search_unselected")
                        .renderingMode(.template)
                    Text("검색")
                }
            
            CurationView()
                .tabItem {
                    Image("tabview_curation_unselected")
                        .renderingMode(.template)
                    Text("큐레이션")
                }
            
            MyPageView()
                .tabItem {
                    Image("tabview_mypage_unselected")
                        .renderingMode(.template)
                    Text("마이")
                }
        }
        .tint(CustomColors.primary05)
    }
}

#Preview {
    MainTapView()
}