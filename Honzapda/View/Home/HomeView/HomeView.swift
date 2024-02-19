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
import Combine

struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showModal = false
    @State private var currentPage = 0
    @State private var isCardTapped = false
    @State private var currentTripIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State public var isSheetVisible = false // 뷰의 표시 여부를 결정하는 상태 변수
    @ObservedObject var homeViewModel : HomeViewModel
    @State var detailShopId : Int = 0
    @State var gotoDetailBool : Bool  = false
  
   
    
    //  var tempDataSetArr: [IntegratedCafe] //임시 데이터용
    
    init( homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
       
    }
    
    func isDetailShopIdSaved() -> Bool {
        return homeViewModel.savedCafeModel.savedCafeList.contains { cafe in
            cafe.id == detailShopId
        }
    }
    func getIndexOfStartingCard( startStore : Int) -> Int {
        return homeViewModel.integratedCafeArr.firstIndex { cafe in
               cafe.dataFromId == startStore
        } ?? 0
    }
    
    @MainActor
    
    var body: some View {
        NavigationView{
            
            
            
            ZStack {
                NavigationLink(destination: ShopDetailView(shopId: detailShopId), isActive: $gotoDetailBool) {
                    EmptyView()
                }
                
                GeometryReader { geometry in
                    KakaoMapView(draw: $homeViewModel.draw, locationManager: locationManager, homeViewModel: homeViewModel)
                        .zIndex(1)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
                        .ignoresSafeArea()
                        .onAppear {
                            print("KM on appear")
                            //homeViewModel.loadCafesAndDraw()
                            //     homeViewModel.kakaoCafeViewModel.fetchData()
                            homeViewModel.savedCafeModel.fetchShops(page: 0, size: 10)
                            homeViewModel.draw = true
                        }
                        .onDisappear {
                            homeViewModel.draw = false
                        }
                    if homeViewModel.CardViewIsShowing{
                        VStack{
                            Spacer()
                            Carousel(pageCount: homeViewModel.integratedCafeArr.count,
                                     visibleEdgeSpace: 30, 
                                     spacing: 0,
                                     startingIndex: getIndexOfStartingCard(startStore: homeViewModel.startingStoreId)) { index in
                                // Carousel에서 각 페이지에 해당하는 CardView를 생성
                                CardView(
                                    homeViewModel: homeViewModel,
                                    savedChecker: isDetailShopIdSaved(), // 예시로 false를 지정, 실제 사용 시 적절한 상태값 전달 필요
                                    dataset: homeViewModel.integratedCafeArr[index],
                                    shopID: homeViewModel.integratedCafeArr[index].dataFromId,
                                    gotoDetailBool: $gotoDetailBool,
                                    detailShopId: $detailShopId
                                    
                                )
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
                                .cornerRadius(15)
                                .shadow(radius: 3)
                                
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.5 + 10)
                            .offset(y: -1)
                            .onAppear(){
                                print("carousel start at : \(getIndexOfStartingCard(startStore: homeViewModel.startingStoreId))")
                            }
                        }
                        .zIndex(2)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom, 100)
                    }
                    
                    //방법2
                    if isSheetVisible{
                        HomeBottomSheetView(homeViewModel: homeViewModel)
                            .zIndex(3)
                            .transition(.move(edge: .bottom))
                            .offset(y : UIScreen.main.bounds.height/2)
                    }
                    
                }
                
                VStack{
                    Button {
                        print("centerIcon tapp")
                        print("KakaoMapView's HomeViewModel address: \(Unmanaged.passUnretained(homeViewModel).toOpaque())")
                        
                    } label: {
                        Image("CenterIcon")
                    }
                    .padding(.bottom, -10)
                    Button {
                        homeViewModel.savedCafeModel.fetchShops(page: 0, size: 10)
                        print("Saved icon tapped")
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isSheetVisible.toggle()
                        }
                        // isSheetVisible.toggle()
                    } label: {
                        Image("SaveIcon")
                    }
                    
                }
                .offset(x : 170, y : -200)
                
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
                
            }
            
            .onAppear {
                locationManager.requestLocationAuthorization()
                // 데이터 로딩 및 기타 초기화 작업...
            }
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
        HomeView(homeViewModel: HomeViewModel())
    }
}

