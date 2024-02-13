//
//  HomeBottomSheet.swift
//  Honzapda
//
//  Created by 이재용 on 2/8/24.
//

import SwiftUI

struct HomeBottomSheetView: View {
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var homeViewModel : HomeViewModel
 // let DataSetArr = tempDataSetArr
    
  var body: some View {
      ZStack{
          Image("Background_Onboarding")
              .resizable() // 이미지 크기 조정 가능하도록 설정
              .aspectRatio(contentMode: .fill) // 이미지를 프레임에 꽉 차게 채움
              .clipped() // 프레임을 넘어서는 부분을 잘라냄
          
          VStack{
              HStack{
                  Text("내가 저장한 카페")
                  .font(Font.custom("S-Core Dream", size: 20))
                  .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                  Spacer()
                  
              }.padding(.leading, 24)
                  .padding(.vertical)
                  
              
             ScrollView{
                  LazyVGrid(columns: columns) {
                      ForEach(homeViewModel.integratedCafeArr) { data in
                        ZStack{
                            Image(data.cafeImage ?? "CafeSampleIMG")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 165, height: 150)
                                .clipped()
                                
                            VStack{
                                HStack{
                                    Text(data.placeName!)
                                        .font(Font.custom("S-Core Dream", size: 12))
                                        .foregroundColor(.white)
                                        
                                    Spacer()
                                }
                                
                                HStack{
                                    Text(data.address!)
                                        .font(Font.custom("S-Core Dream", size: 6))
                                        .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    Spacer()
                                }
                            }
                            .padding(.leading)
                            .offset(y:40)
                        }
                        .frame(width: 165, height: 150)
                            .cornerRadius(15)
                    }
                  }
                  .padding()
              }
          }
          
      }
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
  }
}

struct HomeBottomSheetPreview : PreviewProvider {
    static var previews: some View{
        //BottomSheetView()
        HomeBottomSheetView(homeViewModel: HomeViewModel())
    }
}
