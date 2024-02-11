//
//  HomeView.swift
//  Honzapda
//
//  Created by 이희주 on 2024/01/17.
//
/*
 Todo
 1. 임시 데이터에서 실제 데이터로 변환
 2. 포이 터치 이벤트에서 해당 카페를 가리키는 것 확인
 */
import CoreLocation
import SwiftUI

import KakaoMapsSDK


struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State var draw: Bool = false
    @State private var showModal = false
    @State private var currentPage = 0
    @StateObject private var dataViewModel = DataViewModel() // DataViewModel 객체 생성
    @State private var isCardTapped = false
    @State private var currentTripIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State public var isSheetVisible = false // 뷰의 표시 여부를 결정하는 상태 변수
    @ObservedObject var homeViewModel : HomeViewModel
    
    var tempDataSetArr: [TabViewDataset] //임시 데이터용
    
    init(tempDataSetArr: [TabViewDataset], homeViewModel: HomeViewModel) { // 임시 데이터용
        
        self.tempDataSetArr = tempDataSetArr
        self.homeViewModel = homeViewModel
        
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                KakaoMapView(draw: $draw, locationManager: locationManager, homeViewModel: homeViewModel)
                    .zIndex(1)
                
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
                    .ignoresSafeArea()
                    .onAppear {
                        dataViewModel.fetchData { documents in
                            for document in documents {
                                createMapPoints(from: document)
                            }
                        }
                        self.draw = true
                    }
                    .onDisappear {
                        self.draw = false
                    }
                if homeViewModel.CardViewIsShowing{
                    
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
                    .zIndex(2)
                    .offset(y : 200)
                    .frame(height: 500) // 카드 뷰 높이 설정
                    
                    
                }
                
                //방법2
                if isSheetVisible{
                    HomeBottomSheetView()
                        .zIndex(3)
                        .transition(.move(edge: .bottom))
                        .offset(y : UIScreen.main.bounds.height/2)
                }
                
            }
            
            VStack{
                Button {
                    print("centerIcon tapp")
                } label: {
                    Image("CenterIcon")
                }
                .padding(.bottom, -10)
                Button {
                    print("Saved icon tapped")
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isSheetVisible.toggle()
                    }
                    // isSheetVisible.toggle()
                } label: {
                    Image("SaveIcon")
                }
                
            }
            //방법 1
            //            .sheet(isPresented: $isSheetVisible){
            //
            //
            //                if #available(iOS 16.0, *) {
            //
            //
            //                                HomeBottomSheetView()
            //                                    .presentationDetents([.medium, .large]) // iOS 16 이상에서 사용할 수 있는 기능
            //
            //                            } else {
            //                                // iOS 15 이하에서는 기본 시트 사용
            //                                HomeBottomSheetView()
            //                            }
            //
            //            }
            
            .offset(x : 170, y : -200)
        }
        
        .onAppear {
            print("HomeView's HomeViewModel address: \(Unmanaged.passUnretained(homeViewModel).toOpaque())")
            
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
        HomeView(tempDataSetArr: tempDataSetArr, homeViewModel: HomeViewModel())
    }
}

