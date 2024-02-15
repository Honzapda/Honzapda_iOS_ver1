//
//  ShopDetailMainView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/21.
//

import Foundation
import SwiftUI

struct ShopDetailMainView: View{
    
    @ObservedObject var vm: ShopDetailViewModel
    
    let shopId: Int
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View{
            ScrollView(.vertical, showsIndicators: false){
                // MARK: Show Shop Image
                VStack {
                    shopImage()
                    
                    // MARK: detailView
                    detailView()
                        .frame(width: size.width)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .zIndex(0)
                }
                .overlay(alignment: .top){
                    headerView()
                }
            }
            .navigationBarBackButtonHidden()
            .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func shopImage()->some View{
        let height = size.height * 0.30
        
        GeometryReader{proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8 ))
            
            AsyncImage(url: getUrl(from: vm.shopDetail?.result.mainImage)) { image in
                image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + 25 + (minY > 0 ? minY : 0))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom){
                        // MARK: Gradient Overlay
                        Rectangle()
                            .fill( .background.opacity(0))
                        HStack{
                            VStack(alignment:.leading){
                                HStack(spacing: 16){
                                    Text(vm.shopDetail?.result.shopName ?? "")
                                        .font(Font.custom("S-CoreDream-6Bold", size: 22))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    if let isOpen = vm.shopDetail?.result.openNow {
                                        if isOpen == true {
                                            Text("영업중")
                                                .font(Font.custom("S-Core Dream", size: 8))
                                                .foregroundColor(.white)
                                                .padding([.top,.bottom], 8)
                                                .padding(.horizontal)
                                                .overlay(RoundedRectangle(cornerRadius: 15)
                                                    .stroke(.white, lineWidth: 1)
                                                )
                                        }
                                        else{
                                            Text("영업종료")
                                                .font(Font.custom("S-Core Dream", size: 8))
                                                .foregroundColor(.white)
                                                .padding([.top,.bottom], 8)
                                                .padding(.horizontal)
                                                .overlay(RoundedRectangle(cornerRadius: 15)
                                                    .stroke(.white, lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                                    
                                Text((vm.shopDetail?.result.address ?? "") + " " + (vm.shopDetail?.result.addressSpec ?? ""))
                                        .font(Font.custom("S-Core Dream", size: 10))
                                        .foregroundColor(CustomColors.white)
                                    
                                    HStack(spacing: 8){
                                        Image("icon_phone")
                                            .renderingMode(.template)
                                            .frame(height: 12)
                                        Text(vm.shopDetail?.result.shopPhoneNumber ?? "")
                                            .font(Font.custom("S-Core Dream", size: 10))
                                    }
                                
                                .foregroundStyle(CustomColors.white)
                            }
                            Spacer()
                            VStack(spacing: 8){
                                Image("icon_heart")
                                    .renderingMode(.template)
                                    .foregroundStyle(CustomColors.white)
                                Text("가게\n찜하기")
                                    .multilineTextAlignment(.center)
                                    .font(Font.custom("S-Core Dream", size: 8))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(CustomColors.white)
                            }
                        }
                        .opacity(1 + ( progress > 0 ? -progress : progress))
                        .padding(.bottom, 32)
                        .padding(.leading)
                        .padding(.trailing)
                        //Moving With ScrollView
                        //.offset(y: minY < 0 ? minY : 0)
                    }
                })
                .offset(y: -minY)
            } placeholder: {
                //ProgressView()
            }
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func detailView()->some View{
            VStack{
                VStack(alignment: .leading, spacing: 25){
                    Text("카페 정보")
                        .font(Font.custom("S-CoreDream-6Bold", size: 16))
                        .foregroundStyle(CustomColors.gray09)
                        .padding(.top, 40)
                
                        HStack(){
            
                            VStack{
                                Image("icon_marker")
                                Text(vm.shopDetail?.result.stationDistance ?? "")
                            }
                            Spacer()
                            VStack{
                                Image("icon_star")
                                Text("평점\n"+String(format: "%.2f", vm.shopDetail?.result.rating ?? 0))
                            }
                            Spacer()
                            VStack{
                                Image("icon_paper")
                                // MARK: review list 수정 필요
                                Text(String(vm.shopDetail?.result.reviewCount ?? 0))
                            }
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    .font(Font.custom("S-CoreDream-5Medium", size: 10))
                    .foregroundStyle(CustomColors.primary06)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 25){
                        Text("카페 소개")
                            .font(Font.custom("S-CoreDream-6Bold", size: 16))
                            .foregroundStyle(CustomColors.gray09)
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(minWidth:330, minHeight: 70)
                            .background(CustomColors.gray02)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay{
                                Text(vm.shopDetail?.result.description ?? "")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("S-CoreDream-5Medium", size: 10))
                                .padding()
                        }
                    }
                }
                .padding(.bottom, 40)
                
                Rectangle()
                    .frame(minWidth: size.width)
                    .foregroundStyle(CustomColors.gray01)
                
                DensityInfoView()
                
                Rectangle()
                    .frame(minWidth: size.width)
                    .foregroundStyle(CustomColors.gray01)
                
                //HelpInfoView()
                //    .padding(.vertical, 40)
                
                Rectangle()
                    .frame(minWidth: size.width)
                    .foregroundStyle(CustomColors.gray01)
                
                ReviewView(vm: self.vm)
                    .padding(.vertical, 40)
        }
        .padding(25)
    }
    
    @ViewBuilder
    func headerView()->some View{
        GeometryReader{proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.30
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8 ))
            let titleProgress = minY / height
            
            HStack{
                Button{
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.vertical, 12)
            .padding(.leading)
            .overlay(content: {
                VStack(alignment: .leading){
                    HStack{
                        Button{
                            
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .foregroundStyle(.black)
                        }
                        .padding(.trailing, 25)
                        .padding(.leading)
                        
                        Text(vm.shopDetail?.result.shopName ?? "")
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
                .frame(height: 45)
                .offset(y: -titleProgress > 1 ? 00 : 35)
                .clipped()
                .animation(.easeInOut(duration: 0.05), value: -titleProgress > 1)
            })
            .padding(.top, safeArea.top)
            .background(content: {
                Color.white
                    .opacity(-titleProgress > 1 ? 1 : 0)
            })
            .offset(y: -minY)
        }
    }
    
    func getUrl(from urlString: String?) -> URL? {
        guard let urlString_ = urlString else { return nil}
        
            guard let url = URL(string: urlString_) else {
              return nil
            }
        return url
    }
}
