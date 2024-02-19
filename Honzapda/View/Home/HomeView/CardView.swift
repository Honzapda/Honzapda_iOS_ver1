//
//  CardView.swift
//  Honzapda
//
//  Created by 이재용 on 2/8/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    @ObservedObject var homeViewModel : HomeViewModel
    @State var savedChecker : Bool
    
    var dataset: IntegratedCafe
    let shopID : Int
    @Binding var gotoDetailBool: Bool
    @Binding var detailShopId: Int
    var body: some View {
        
        VStack(){
            
            ZStack{
                
                AsyncImage(url: URL(string: dataset.cafeImage ?? "")) {
                    // 이미지가 성공적으로 로드되었을 때의 뷰
                    image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 8 / 10, height: UIScreen.main.bounds.height * 0.23)
                        .clipped()
                        .overlay(Color.black.opacity(0.3))
                        .onTapGesture {
                            self.gotoDetailBool = true
                            self.detailShopId = shopID
                            
                        }
                } placeholder: {
                    // 이미지 로드 중 또는 URL이 nil인 경우 표시할 뷰
                    Image("CafeSampleIMG")
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.8) // 최외곽 VStack의 너비에 맞춤
                        .clipped() // VStack의 경계를 넘어가는 부분을 잘라냄
                        .onTapGesture {
                            self.gotoDetailBool = true
                            self.detailShopId = shopID
                            
                        }
                }
                .clipped()
                
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Text(dataset.placeName!)
                                .font(Font.custom("S-CoreDream-7ExtraBold", size: 17))
                                .foregroundColor(.white)
                            Image("OnWorking")
                        }
                        
                        Text(dataset.address!)
                            .font(Font.custom("S-CoreDream-5Medium", size: 8))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.top, -2)
                        
                        HStack{
                            Image("PhoneIcon")
                            Text(dataset.phoneCall!)
                                .font(Font.custom("S-CoreDream-5Medium", size: 8))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            
                        }
                        .padding(.top, 5)
                        
                        HStack{
                            Image("MegaPhone")
                                
                            Text(dataset.discription!)
                                .font(Font.custom("S-CoreDream-5Medium", size: 8))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                              
                            Spacer()
                            
                            Button {
                                print("cafe save button tapped")
                                //MARK: here need change
                                if savedChecker{
                                    deleteCafe(shopId: dataset.dataFromId)
                                    homeViewModel.savedCafeModel.fetchShops(page: 0, size: 10)
                                }
                                else {
                                    
                                    saveCafe(shopId: dataset.dataFromId)
                                    homeViewModel.savedCafeModel.fetchShops(page: 0, size: 10)
                                    savedChecker = true
                                }
                                
                            } label: {
                                VStack{
                                    if savedChecker{
                                        Image("Flag")
                                            .foregroundColor(CustomColors.primary05)
                                    }
                                    else{
                                        Image("Flag")
                                    }
                                    
                                    Text("카페 저장하기")
                                        .font(Font.custom("S-CoreDream-5Medium", size: 4))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                }
                            }
                        }.padding(.top, -3)
                    }
                    Spacer()
                }
                .offset(y: 50)
                .padding(.horizontal, 20)
                
                // 추가 데이터 표시
                
                Image("CardBackgroundImg")
                    .resizable()
              
                    .scaledToFit()
                    .frame(maxWidth : 200, maxHeight: 200)
                    .offset(x:80, y:270)
            }
            .zIndex(1)
           
            .offset(y:-15)
            .frame(width: UIScreen.main.bounds.width * 8 / 10, height: UIScreen.main.bounds.height * 2.3 / 10)
            
            
            VStack{
                HStack{
                    (Text(dataset.placeName!) + Text("의 정보 >"))
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        
                    Spacer()
                }
                .padding(.leading)
                
                HStack{
                    VStack{
                        Image("FarFrom")
                            .resizable()
                            .frame(width: 18, height: 22)
                        Text(dataset.posFromStation!)
                            .font(Font.custom("S-Core Dream", size: 7))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(CustomColors.gray04)
                    
                    
                    
                    
                    VStack{
                        Image("Star")
                            .resizable()
                            .frame(width: 18, height: 22)
                        Text("\(String(format: "%.2f", Double(dataset.rating!) ?? 0.0)) / 5")
                            .frame(maxWidth: .infinity)
                            .font(Font.custom("S-Core Dream", size: 7))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                            
                        
                    }
                    .padding()
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(CustomColors.gray04)
                    
                    VStack{
                        Image("Reviews")
                            .resizable()
                            .frame(width: 18, height: 22)
                        Text("리뷰\(dataset.reviewCount!) 개")
                            .frame(maxWidth: .infinity)
                            .font(Font.custom("S-Core Dream", size: 7))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                            
                    }
                    .padding()
                }
                .frame(height: 63, alignment: .top)
                
                HStack{
                    Text("\(dataset.placeName!)의 요일별 혼잡도")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    Image("Union")
                        .resizable()
                        .frame(width: 10, height: 10)
                    
                    Spacer()
                }.padding(.leading)
                    .padding(.vertical, 10)
                
                HStack{
                    ForEach(0..<dataset.densityOfDays!.count, id: \.self) { index in
                        VStack {
                            Text(dayOfWeek(index: index))
                                .font(Font.custom("S-CoreDream-5Medium", size: 7))
                                .padding(.bottom, -2)
                            
                            Image(imageName(value: dataset.densityOfDays![index]))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 20) // 예시 크기, 필요에 따라 조정
                            
                        }
                        .frame(width: 30, height: 48, alignment: .center)
                        // VStack 내부의 요소들에 대한 패딩 추가
                        .background(Color.white) // VStack에 흰색 배경 적용
                        .cornerRadius(5) // 배경의 모서리를 둥글게 처리
                        .shadow(radius: 3) // 그림자 효과 적용
                    }
                }
                .padding(.horizontal, 20)
            }.zIndex(2)
            .frame(width: UIScreen.main.bounds.width * 8 / 10, height: UIScreen.main.bounds.height * 3 / 10)
            .offset(y : -50)
            .background(Color.clear)
        }
        .background(Color.white)
       
        .cornerRadius(16)
        .frame(width: UIScreen.main.bounds.width * 8 / 10, height: UIScreen.main.bounds.height * 5 / 10)
    }
}




// CardView의 프리뷰를 위한 구조체
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        // 예시 데이터를 사용하여 IntegratedCafe 인스턴스 생성
//        let sampleCafe = IntegratedCafe(
//            dataFrom: "kakao/honzapda",
//            dataFromId: 99,
//            placeName: "가게이름",
//            address: "00시 00구 000길 00-0",
//            cafeImage: "https://storage.googleapis.com/honzapda-bucket/58256d81-91ae-495d-8a45-5d49878f275e", // 예시 이미지 URL
//            phoneCall: "010-1111-2222",
//            discription: "카페에 대한 설명을 부탁드려요!",
//            posFromStation: "역에서부터 거리 정보가 없어요",
//            rating: "4.5",
//            reviewCount: "15",
//            x: "127.0",
//            y: "37.0",
//            densityOfDays: [1, 2, 3, 1, 2, 3, 1] // 1: 여유, 2: 중간, 3: 혼잡
//        )
//        
//        // CardView에 sampleCafe 인스턴스를 전달하여 프리뷰 생성
//        CardView(dataset: sampleCafe)
//            .previewLayout(.sizeThatFits) // 프리뷰의 레이아웃을 조정
//    }
//}
