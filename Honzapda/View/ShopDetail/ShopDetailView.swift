//
//  ShopDetailView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//

import Foundation
import SwiftUI

struct ShopDetailView: View {
    @ObservedObject var vm: ShopDetailViewModel = ShopDetailViewModel()
    let shopId: Int
    
    var body: some View {
        NavigationView{
            GeometryReader{
                let safeArea = $0.safeAreaInsets
                let size = $0.size
                ShopDetailMainView(vm: vm, shopId: shopId, safeArea: safeArea, size:size)
                    .ignoresSafeArea(.container, edges: .top)
                    .navigationBarBackButtonHidden()
            }
       }
        .navigationBarBackButtonHidden()
        .onAppear{
            print(vm.shopDetail?.result.mainImage ?? "")
            vm.getShopDetailOnSrever(shopId: shopId)
        }
    }
}
