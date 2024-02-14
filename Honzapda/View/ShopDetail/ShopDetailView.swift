//
//  ShopDetailView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//

import Foundation
import SwiftUI

struct ShopDetailView: View {
    @ObservedObject var vm = ShopDetailViewModel()
    
    var body: some View {
        NavigationView{
            GeometryReader{
                let safeArea = $0.safeAreaInsets
                let size = $0.size
                ShopDetailMainView(safeArea: safeArea, size:size)
                    .ignoresSafeArea(.container, edges: .top)
            }
       }
        .onAppear{
            vm.getShopDetailOnServer(shopId: 1)
        }
    }
}

#Preview {
    ShopDetailView()
}

