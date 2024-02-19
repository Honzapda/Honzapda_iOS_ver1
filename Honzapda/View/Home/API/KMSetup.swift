//
//  ContentView.swift
//  KakaoMapOpenApi-Sample
//
//  Created by chase on 2020/05/19.
//  Copyright © 2020 kakao. All rights reserved.
//
/*
 Todo
 1. poi touch event update -> return poi's id
 2. terrin touch event update -> change poi style
 
 */

import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    //@Binding var startingIndex : Int // 카드뷰 선택용
    @ObservedObject var locationManager : LocationManager
    @ObservedObject  var homeViewModel: HomeViewModel // HomeViewModel 참조 추가
    @StateObject private var viewModel = KakaoCafeViewModel() // DataViewModel 객체 생성
    
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        // 크기를 화면 크기에 맞게 확장
        let view = KMViewContainer()
        //  view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        context.coordinator.createController(view)
        context.coordinator.controller?.initEngine()
        
        return view
    }
    
    
    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                context.coordinator.controller?.startEngine()
                context.coordinator.controller?.startRendering()
            }
        }
        else {
            context.coordinator.controller?.stopRendering()
            context.coordinator.controller?.stopEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        
        return KakaoMapCoordinator(locationManager: locationManager,homeViewModel: homeViewModel )
    }
    
    /// Cleans up the presented `UIView` (and coordinator) in
    /// anticipation of their removal.
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate {
        
        var _mapTapEventHandler: DisposableEventHandler?
        var _terrainTapEventHandler: DisposableEventHandler?
        var locationManager : LocationManager
        var controller: KMController?
        var first: Bool
        var auth: Bool
        var homeViewModel: HomeViewModel // HomeViewModel 참조 추가
        
        init(locationManager: LocationManager, homeViewModel: HomeViewModel) {
            self.locationManager = locationManager
            self.homeViewModel = homeViewModel
            
            first = true
            auth = false
            super.init()
            
        }
        
        
        func createLabelLayer(){
            print("creatLabelLayer")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 10001)
            let _ = manager.addLabelLayer(option: layerOption)
        } // 뷰 지정, 매니저 설정, 레이어옵션 등록, 레이블 레이어 매니저 등록
        
        func createPoiStyle(){
            print("creatpoiStyle")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            
            
            let icon1 = PoiIconStyle(symbol: UIImage(named: "MarkerUnselected.png"), anchorPoint: CGPoint(x: 0.5, y: 0.7))
            let perLevelStyle1 = PerLevelPoiStyle(iconStyle: icon1, level: 0)
            let poiStyle1 = PoiStyle(styleID: "Unselected", styles: [perLevelStyle1])
            manager.addPoiStyle(poiStyle1)
            
            let icon2 = PoiIconStyle(symbol: UIImage(named: "MarkerSelected.svg"), anchorPoint: CGPoint(x: 0.5, y: 0.7))
            let perLevelStyle2 = PerLevelPoiStyle(iconStyle: icon2, level: 0)
            let poiStyle2 = PoiStyle(styleID: "Selected", styles: [perLevelStyle2])
            manager.addPoiStyle(poiStyle2)
            
            let icon3 = PoiIconStyle(symbol: UIImage(named: "MarkerMyPos.png"), anchorPoint: CGPoint(x: 0.5, y: 0.8))
            let perLevelStyle3 = PerLevelPoiStyle(iconStyle: icon3, level: 0)
            let poiStyle3 = PoiStyle(styleID: "userPosition", styles: [perLevelStyle3])
            manager.addPoiStyle(poiStyle3)
            
        } // 포이 스타일 지정
        
        
        func poiTappedHandlerAdded(_ param: PoiInteractionEventParam) {
            DispatchQueue.main.async{
                
                self.homeViewModel.CardViewIsShowing = true
                print(self.homeViewModel.CardViewIsShowing)
                param.poiItem.changeStyle(styleID: "Selected", enableTransition: true)
                
                if let newStartingStoreId = Int(param.poiItem.itemID) {
                    self.homeViewModel.startingStoreId = newStartingStoreId
                  
                } else {
                    print("Error: poiItem.itemID cannot be converted to Int")
                }
                //print( "poi item \(param.poiItem.itemID) // type is \(type(of: param.poiItem.itemID))")
                //print("KakaoMapView's HomeViewModel address: \(Unmanaged.passUnretained(self.homeViewModel).toOpaque())")

                
            }
        }
        
        //포이 생성
        func createPois(){
            
            
            print("createPois")
            
            
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view .getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            layer?.visible = true
            
            let poiOption1 = PoiOptions(styleID: "Unselected", poiID: "poi1")
            poiOption1.rank = 1
            poiOption1.clickable = true
            let poiOption2 = PoiOptions(styleID: "Selected", poiID: "poi2")
            poiOption2.rank = 2
            poiOption2.clickable = true
            let poiOptionMyPos = PoiOptions(styleID: "userPosition", poiID: "poiMyPos")
            poiOption2.rank = 3
            poiOption2.clickable = false
            
            //                        var poiMyPos = layer?.addPoi(option:poiOptionMyPos, at: MapPoint(longitude: locationManager.lon ?? 126.978365,latitude: locationManager.lat ?? 37.566691))
            //
            
            poiArr.forEach { poiData in
                let poiId = poiData.id
                let poiMapPoint = poiData.mapPoint
                let newPoiOption = PoiOptions(styleID: "Unselected", poiID: String(poiId))
                newPoiOption.clickable = true
                newPoiOption.rank = 1
                let newPoi = layer?.addPoi(option: newPoiOption, at: poiMapPoint)
                print(newPoi?.itemID, " < - poi itemId / storeID - >", poiData.id)
                let _ = newPoi?.addPoiTappedEventHandler(target: self, handler: KakaoMapCoordinator.poiTappedHandlerAdded(_:))
            }
            
//                        var pois = layer?.addPois(option: poiOption1, at: mapPoints)
//                        guard let pois = pois else { return }
//                        for poi in pois {
//                            // 여기에서 poi 사용
//                            print("\(poi.itemID) === poiItemID  //  ")
//                            let _ = poi.addPoiTappedEventHandler(target: self, handler: KakaoMapCoordinator.poiTappedHandlerAdded(_:))
//                        }
            var poiMyPos = layer?.addPoi(option:poiOptionMyPos, at: MapPoint(longitude: Double(lon)!,
                                                                             latitude: Double(lat)!))
            //Here!
            
            //  var poisWithMultiOpt = layer?.addPois(options: poiOptions, at: mapPoints) //
            
            
            layer?.showAllPois()
            
        }
        
        
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        
        func addViews() {
            
            
            let defaultPosition: MapPoint = MapPoint(longitude: Double(lon) ?? 127.1, latitude: Double(lat) ?? 37.2)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
            
            if controller?.addView(mapviewInfo) == Result.OK {
                let _ = controller?.getView("mapview") as! KakaoMap
            }
            // 탭 이벤트
            let mapView = controller?.getView("mapview") as! KakaoMap
            _mapTapEventHandler = mapView.addMapTappedEventHandler(target: self, handler: KakaoMapCoordinator.mapDidTapped)
            _terrainTapEventHandler = mapView.addTerrainTappedEventHandler(target: self, handler: KakaoMapCoordinator.terrainTapped)
            
            createLabelLayer()
            createPoiStyle()
            createPois()
        }
        
        func containerDidResized(_ size: CGSize) {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
            if first {
                
                //                let cameraUpdate: CameraUpdate = CameraUpdate.make(
                //                    target: MapPoint(longitude: locationManager.lon ?? 126.978365,
                //                                     latitude: locationManager.lat ?? 37.566691),
                //                    zoomLevel: 17, mapView: mapView!)
                let cameraUpdate: CameraUpdate = CameraUpdate.make(
                    target: MapPoint(longitude: Double(lon)!,
                                     latitude: Double(lat)!),
                    zoomLevel: 16, mapView: mapView!)
                
                
                mapView?.moveCamera(cameraUpdate)
                first = false
            }
        }
        
        func authenticationSucceeded() {
            auth = true
        }
        func mapDidTapped(_ param: ViewInteractionEventParam) {
            
            DispatchQueue.main.async {
                let mapView = param.view as! KakaoMap
                let position = mapView.getPosition(param.point)
                let view = self.controller?.getView("mapview") as! KakaoMap
                let manager = view .getLabelManager()
                let layer = manager.getLabelLayer(layerID: "PoiLayer")
                let poiList = layer?.getAllPois()
                print("Tapped: \(position.wgsCoord.latitude), \(position.wgsCoord.latitude)")
                if self.homeViewModel.CardViewIsShowing {
                    self.homeViewModel.CardViewIsShowing = false
                    poiList?.forEach({ Poi in
                        Poi.changeStyle(styleID: "Unselected", enableTransition: true)
                        Poi.show()
                    })
                    
                }
            }
            
        }
        
        func terrainTapped(_ param: TerrainInteractionEventParam) {
            DispatchQueue.main.async {
                let position = param.position.wgsCoord
                let view = self.controller?.getView("mapview") as! KakaoMap
                let manager = view .getLabelManager()
                let layer = manager.getLabelLayer(layerID: "PoiLayer")
                let poiList = layer?.getAllPois()
                print("Terrain Tapped: \(position.longitude), \(position.latitude)")
                if self.homeViewModel.CardViewIsShowing {
                    self.homeViewModel.CardViewIsShowing = false
                    poiList?.forEach({ Poi in
                        Poi.changeStyle(styleID: "Unselected", enableTransition: true)
                        Poi.show()
                    })
                    
                }
            }
        }
        //        func poiTouched(_ poi: Poi) {
        //            print(poi.itemID)
        //        }
        //        func touchesBegan(_ touches: Set<AnyHashable>) {
        //            if let touch = touches.first as? UITouch {
        //                let radius = touch.majorRadius
        //                let touchedCenter = touch.location(in: touch.window)
        //                // touch major radius기준으로 거리 재기 위한 임시 Point
        //                let withRadius = CGPoint(x: touchedCenter.x + radius, y: touchedCenter.y)
        //                if let point = getPosition(touchedCenter),
        //                   let withRadiusPoint = getPosition(withRadius)
        //                {
        //                    // 거리 계산
        //                    let latdist = (point.wgsCoord.latitude - withRadiusPoint.wgsCoord.latitude)
        //                    let longdist = (point.wgsCoord.longitude - withRadiusPoint.wgsCoord.longitude)
        //                    let powdDist = latdist * latdist + longdist * longdist
        //                    let dist = sqrt(powdDist) // radius의 map상에서의 거리
        //
        //                    if let touchedPoi = touchedPOI(point.wgsCoord, dist) {
        //                        poiTouched(touchedPoi)
        //                    }
        //                }
        //            }
        //        }
        //        private func touchedPOI(_ coord: GeoCoordinate, _ dist: Double) -> Poi? {
        //            if let map = controller?.getView("mapview") as? KakaoMap {
        //                let manager = map.getLabelManager()
        //                let layer = manager.getLabelLayer(layerID: "PoiLayer")
        //                guard let pois = layer?.getAllPois() else {return nil}
        //                var touchedPois: [Poi : Double] = [:] // value = distance
        //                for poi in pois {
        //                    let latdist = (coord.latitude - poi.position.wgsCoord.latitude)
        //                    let longdist = (coord.longitude - poi.position.wgsCoord.longitude)
        //                    let powdDist = latdist * latdist + longdist * longdist
        //                    let distWithPoi = sqrt(powdDist)
        //                    // touched radius 반경 안에 있는 경우
        //                    if distWithPoi < dist {
        //                        touchedPois[poi] = distWithPoi
        //                    }
        //                }
        //                if touchedPois.isEmpty { return nil }
        //                else { return touchedPois.sorted(by: {$0.value < $1.value}).first!.key} // 가장 가까운 poi를 리턴합니다.
        //            }
        //            return nil
        //        }
        //        private func getPosition(_ point: CGPoint) -> MapPoint? {
        //            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
        //
        //            guard let map = mapView else
        //            {return nil}
        //            return map.getPosition(point)
        //        }
    }
}

