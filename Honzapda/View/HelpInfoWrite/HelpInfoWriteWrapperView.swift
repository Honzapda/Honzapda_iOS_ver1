//
//  HelpInfoWriteWrapperView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/18.
//

import Foundation
import SwiftUI

struct HelpInfoWriteWrapperView: View {
    @Environment(\.dismiss) private var dismiss
    
    var shopId: Int?
    var shopName: String?
    
    var body: some View {
        NavigationView{
            GeometryReader{proxy in
                let safeArea = proxy.safeAreaInsets
                let minY = proxy.frame(in:.global).minY
                
                ZStack(alignment: .top){
                    HelpInfoWriteView(ShopId: shopId ?? 0)
                        .navigationBarBackButtonHidden()
                    
                    headerView()
                        .padding(.top, safeArea.top)
                        .offset(y: -minY)
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    @ViewBuilder
    func headerView()->some View{
        VStack(alignment: .leading){
            HStack(){
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
                .padding(.trailing, 25)
                .padding(.leading)
                 
                // MARK: 가게 이름
                Text(shopName ?? "")
                    .font(Font.custom("S-Core Dream", size: 14))
                    .foregroundStyle(.black)
                    .padding(.vertical, 12)
                
                Spacer(minLength: 0)
                
                Button{
                    
                } label: {
                    Image("icon_heart")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 18)
                        .padding(.trailing,24)
                        .foregroundStyle(CustomColors.primary05)
                }
            }
            
            Spacer()
            
            Divider()
        }
        .background(CustomColors.white)
        .frame(height: 45)
    }
}
