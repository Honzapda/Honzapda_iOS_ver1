//
//  HomeView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/17.
//

import CoreLocation
import SwiftUI


struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State var draw: Bool = false
    @State private var showModal = false
    @State private var currentPage = 0
    //   var dataSetArr : [TabViewDataset] = []
    @StateObject private var viewModel = DataViewModel() // DataViewModel 객체 생성
    @State private var isCardTapped = false
    @State private var currentTripIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isViewVisible = false // 뷰의 표시 여부를 결정하는 상태 변수

    var tempDataSetArr: [TabViewDataset]
    
    init(tempDataSetArr: [TabViewDataset]) {
        
        self.tempDataSetArr = tempDataSetArr
        
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                KakaoMapView(draw: $draw, locationManager: locationManager)
                //.frame(width: geometry.size.width, height: geometry.size.height)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
                //    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .onAppear {
                        viewModel.fetchData { documents in
                            for document in documents {
                                createMapPoints(from: document)
                            }
                        }
                        self.draw = true
                    }
                    .onDisappear {
                        self.draw = false
                    }
                if isViewVisible{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(0..<tempDataSetArr.count, id: \.self) { index in
                                GeometryReader { itemGeometry in
                                    CardView(dataset: tempDataSetArr[index])
                                        .scaleEffect(scaleValue(globalMinX: itemGeometry.frame(in: .global).minX, geometrySize: geometry.size))
                                        .animation(.easeInOut(duration: 0.1), value: scaleValue(globalMinX: itemGeometry.frame(in: .global).minX, geometrySize: geometry.size))
                                        .transition(.opacity)
                                        
                                    
                                }
                                .frame(width: 300)
                                .padding(.horizontal, 20)
                                //   .border(Color.blue)
                            }
                        }
                        .offset(y: 50)
                        .padding(.horizontal) // 첫 번째 및 마지막 카드가 중앙에 오도록 패딩 조정
                    }
                    .offset(y : 200)
                    .frame(height: 500) // 카드 뷰 높이 설정
                    
                    
                }
            }
            
            
           
            VStack{
                Button {
                    print("reset icon tapped")
                    
                } label: {
                    Image("CenterIcon")
                }
                .padding(.bottom, -10)
                Button {
                    print("reset icon tapped")
                    isViewVisible.toggle()
                } label: {
                    Image("SaveIcon")
                }
            }
            .offset(x : 170, y : -200)
        }
        .onAppear {
            locationManager.requestLocationAuthorization()
            // 데이터 로딩 및 기타 초기화 작업...
        }
        
    }
}

private func scaleValue(globalMinX: CGFloat, geometrySize: CGSize) -> CGFloat {
    let itemWidth: CGFloat = 300 // 기본 카드 너비
    let center = geometrySize.width / 2
    let distanceFromCenter = abs(globalMinX + itemWidth / 2 - center)
    let activeDistance: CGFloat = 50 // 활성화 거리, 이 거리 내에서 스케일 변화 적용

    if distanceFromCenter < activeDistance {
        // 중앙에 가까운 카드는 가로 세로로 10포인트만큼 더 커집니다.
        let extraSize: CGFloat = 10 // 가로 세로로 더 커지는 크기
        let scale = 1 + extraSize / itemWidth // 스케일 계산
        return scale
    } else {
        // 중앙에서 멀어지면 기본 스케일로 돌아갑니다.
        return 1
    }
}




struct HomeViewPreviews : PreviewProvider {
    static var previews: some View{
       // CardView(dataset: tempDataSetArr[0])
        HomeView(tempDataSetArr: tempDataSetArr)
    }
}

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



// 팝업
//                 ScrollView(.horizontal, showsIndicators : false){
//                GeometryReader{ outerView in
//                    HStack(alignment: .center){
//                        ForEach(tempDataSetArr.indices, id : \.self) {index in
//                            GeometryReader{ innerView in
//
//                                CardView(dataset: tempDataSetArr[index])
//                                    .shadow(radius: 5)
//                            }
//                            .border(Color.red)
//                            .frame(width: outerView.size.width * 8/10, height: 450)
//                            .padding(.horizontal, 20)
//
//                        }
//                    }
//                    .border(Color.black)
//                    .frame(width: outerView.size.width, height:  outerView.size.height, alignment:.leading)
//                }
//
//                        .border(Color.black)
//            //        }// 스크롤
//                .frame(width: geometry.size.width, height: geometry.size.height)
//                .offset(x: -CGFloat(self.currentTripIndex) * geometry.size.width, y : 80)
//                .offset(x : self.dragOffset)
//                .gesture(
//                DragGesture()
//                    .updating(self.$dragOffset, body: { (value, state, _ ) in
//                        state = value.translation.width
//                    })
//                    .onEnded({ (value) in
//                        let threshold = geometry.size.width * 0.3
//                        let offset = value.translation.width
//                        var newIndex = Int (offset / threshold) + self.currentTripIndex
//                        //newIndex = min(max(newIndex, 0), tempDataSetArr.count -1)
//                        self.currentTripIndex = min(max(newIndex,0), self.tempDataSetArr.count)
//                    }))
