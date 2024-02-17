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
            
            let icon2 = PoiIconStyle(symbol: UIImage(named: "icon_marker.svg"), anchorPoint: CGPoint(x: 0.5, y: 0.7))
            let perLevelStyle2 = PerLevelPoiStyle(iconStyle: icon2, level: 0)
            let poiStyle2 = PoiStyle(styleID: "Selected", styles: [perLevelStyle2])
            manager.addPoiStyle(poiStyle2)
            
            let icon3 = PoiIconStyle(symbol: UIImage(named: "MarkerMyPos.png"), anchorPoint: CGPoint(x: 0.5, y: 0.8))
            let perLevelStyle3 = PerLevelPoiStyle(iconStyle: icon3, level: 0)
            let poiStyle3 = PoiStyle(styleID: "userPosition", styles: [perLevelStyle3])
            manager.addPoiStyle(poiStyle3)
            
        } // 포이 스타일 지정
        
        
        func poiTappedHandlerAdded(_ param: PoiInteractionEventParam) {
            homeViewModel.CardViewIsShowing.toggle()
          //  print(homeViewModel.CardViewIsShowing)
          
            param.poiItem.changeStyle(styleID: "Selected", enableTransition: true)
            
            print( "poi item \(param.poiItem.itemID) // type is \(type(of: param.poiItem.itemID))")
           
            print("KakaoMapView's HomeViewModel address: \(Unmanaged.passUnretained(homeViewModel).toOpaque())")
            
        
       
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
            
//            var poiMyPos = layer?.addPoi(option:poiOptionMyPos, at: MapPoint(longitude: locationManager.lon ?? 126.978365,latitude: locationManager.lat ?? 37.566691))
            var poiMyPos = layer?.addPoi(option:poiOptionMyPos, at: MapPoint(longitude: Double(lon)!,
                                                                             latitude: Double(lat)!))
            //Here!
         
          //  var poisWithMultiOpt = layer?.addPois(options: poiOptions, at: mapPoints) //
            var pois = layer?.addPois(option: poiOption1, at: mapPoints)
//
//            poiArr.forEach { poiData in
//                let poiId = poiData.id
//                let poiMapPoint = poiData.mapPoint
//                let newPoiOption = PoiOptions(styleID: "Unselected", poiID: String(poiId))
//                var newPoi = layer?.addPoi(option: poiOption1, at: poiData.mapPoint)
//                let _ = newPoi?.addPoiTappedEventHandler(target: self, handler: KakaoMapCoordinator.poiTappedHandlerAdded(_:))
//                
//            }
            layer?.showAllPois()
            guard let pois = pois else { return }
            for poi in pois {
                // 여기에서 poi 사용
                print(poi.itemID)
                
                let _ = poi.addPoiTappedEventHandler(target: self, handler: KakaoMapCoordinator.poiTappedHandlerAdded(_:))
            }
            
        }
        
        
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        
        func addViews() {
            
            
            let defaultPosition: MapPoint = MapPoint(longitude: locationManager.lon ?? 127.1, latitude: locationManager.lat ?? 37.2)
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
                    zoomLevel: 17, mapView: mapView!)
                
                
                mapView?.moveCamera(cameraUpdate)
                first = false
            }
        }
        
        func authenticationSucceeded() {
            auth = true
        }
        func mapDidTapped(_ param: ViewInteractionEventParam) {
            let mapView = param.view as! KakaoMap
            let position = mapView.getPosition(param.point)
            
            
            print("Tapped: \(position.wgsCoord.latitude), \(position.wgsCoord.latitude)")
            
            if homeViewModel.CardViewIsShowing {
                homeViewModel.CardViewIsShowing = false
            }
        }
        
        func terrainTapped(_ param: TerrainInteractionEventParam) {
            let position = param.position.wgsCoord
            print("Terrain Tapped: \(position.longitude), \(position.latitude)")
            if homeViewModel.CardViewIsShowing {
                homeViewModel.CardViewIsShowing = false
            }
            
        }
    }
}

