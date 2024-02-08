//
//  CardView.swift
//  Honzapda
//
//  Created by 이재용 on 2/8/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    var dataset: TabViewDataset
    
    var body: some View {
    
        VStack(alignment: .center){
                
                ZStack{
                
                    Image(dataset.cafeImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: -17)
                        .clipped()
                    
                    HStack{
                        VStack(alignment: .leading){
                            HStack{
                                Text(dataset.storeName)
                                    .font(Font.custom("S-CoreDream-7ExtraBold", size: 17))
                                    .foregroundColor(.white)
                                Image("OnWorking")
                            }
                        
                            Text(dataset.address)
                                .font(Font.custom("S-CoreDream-5Medium", size: 8))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .padding(.top, -2)
                            
                            HStack{
                                Image("PhoneIcon")
                                Text(dataset.callNumber)
                                    .font(Font.custom("S-CoreDream-5Medium", size: 8))
                                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                
                            }
                            .padding(.top, 5)
                            
                            HStack{
                                Image("MegaPhone")
                                Text(dataset.summery)
                                    .font(Font.custom("S-CoreDream-5Medium", size: 8))
                                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                Spacer()
                                
                                    Button {
                                        print("cafe save button tapped")
                                    } label: {
                                        VStack{
                                            Image("Flag")
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
                    .offset(y: 30)
                    .padding(.leading, 15)
                    
                    // 추가 데이터 표시
                    
                    Image("CardBackgroundImg")
                        .resizable()
                    //.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .scaledToFit()
                        .frame(maxWidth : 200, maxHeight: 200)
                        .offset(x:80, y:200)
                }
               // .border(Color.blue)
                
            VStack{
                HStack{
                Text("\(dataset.storeName)의 정보 >")
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
                    Text(dataset.posFromStation)
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
                    Text("\(dataset.starPoint) / 5")
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
                    Text("리뷰\(dataset.reviewNum) 개")
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("S-Core Dream", size: 7))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.21, green: 0.23, blue: 0.64))
                }
                .padding()
            }
            .frame(height: 63, alignment: .top)
            
            HStack{
                Text("\(dataset.storeName)의 요일별 혼잡도")
                        .font(Font.custom("S-Core Dream", size: 10))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                Image("Union")
                    .resizable()
                    .frame(width: 10, height: 10)
                        
                Spacer()
            }.padding(.leading)
                    .padding(.vertical, 5)
            
            HStack{
                ForEach(0..<dataset.densityOfDays.count, id: \.self) { index in
                    VStack {
                        Text(dayOfWeek(index: index))
                            .font(Font.custom("S-CoreDream-5Medium", size: 7))
                            .padding(.bottom, -2)
                        
                        Image(imageName(value: dataset.densityOfDays[index]))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20) // 예시 크기, 필요에 따라 조정
                        
                    }
                    .frame(width: 36, height: 52, alignment: .center)
                    // VStack 내부의 요소들에 대한 패딩 추가
                    .background(Color.white) // VStack에 흰색 배경 적용
                    .cornerRadius(5) // 배경의 모서리를 둥글게 처리
                    .shadow(radius: 3) // 그림자 효과 적용
                }
            }
            .padding(.horizontal)
            }
            .offset(y: -30)
            }
            .background(Color.white)
            .cornerRadius(16)
            .frame(width: UIScreen.main.bounds.width * 8 / 10, height: UIScreen.main.bounds.height / 2)
        }
    }


