//
//  ContentView.swift
//  KakaoMapOpenApi-Sample
//
//  Created by chase on 2020/05/19.
//  Copyright © 2020 kakao. All rights reserved.
//

import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    @ObservedObject var locationManager : LocationManager
    
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
        return KakaoMapCoordinator(locationManager: locationManager)
    }

    /// Cleans up the presented `UIView` (and coordinator) in
    /// anticipation of their removal.
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var locationManager : LocationManager
        var controller: KMController?
        var first: Bool
        var auth: Bool
        
        func createLabelLayer(){
            print("creatLabelLayer")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 10001)
            let _ = manager.addLabelLayer(option: layerOption)
        }
        func createPoiStyle(){
            print("creatpoiStyle")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            

            let icon1 = PoiIconStyle(symbol: UIImage(named: "MarkerUnselected.png"), anchorPoint: CGPoint(x: 0.0, y: 0.5))
            let perLevelStyle1 = PerLevelPoiStyle(iconStyle: icon1, level: 0)
            let poiStyle1 = PoiStyle(styleID: "nonAdded", styles: [perLevelStyle1])
            manager.addPoiStyle(poiStyle1)
            
            let icon2 = PoiIconStyle(symbol: UIImage(named: "MarkerSelected.png"), anchorPoint: CGPoint(x: 0.0, y: 0.5))
            let perLevelStyle2 = PerLevelPoiStyle(iconStyle: icon2, level: 0)
            let poiStyle2 = PoiStyle(styleID: "Added", styles: [perLevelStyle2])
            manager.addPoiStyle(poiStyle2)
            
            let icon3 = PoiIconStyle(symbol: UIImage(named: "MarkerMyPos.png"), anchorPoint: CGPoint(x: 0.0, y: 0.5))
            let perLevelStyle3 = PerLevelPoiStyle(iconStyle: icon3, level: 0)
            let poiStyle3 = PoiStyle(styleID: "userPosition", styles: [perLevelStyle3])
            manager.addPoiStyle(poiStyle3)
            
        }
        
        func createPois(){
            print("createPois")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view .getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            layer?.visible = true
            
            let poiOption1 = PoiOptions(styleID: "nonAdded")
            poiOption1.rank = 0
            poiOption1.clickable = true
            let poiOption2 = PoiOptions(styleID: "Added")
            poiOption2.rank = 0
            poiOption2.clickable = true
            let poiOptionMyPos = PoiOptions(styleID: "userPosition")
            poiOption2.rank = 0
            poiOption2.clickable = false
            
            var poiMyPos = layer?.addPoi(option:poiOptionMyPos, at: MapPoint(longitude: locationManager.lon ?? 126.978365,latitude: locationManager.lat ?? 37.566691))
            
            var poi2 = layer?.addPoi(option:poiOption1, at: MapPoint(longitude: 126.9783780, latitude:  37.5666612))
            
            var pois = layer?.addPois(option: poiOption1, at: mapPoints)
            layer?.showAllPois()
            
    //        poi2?.addPoiTappedEventHandler(target: self, handler:KakaoMapCoordinator.handlePoiTap)
//            if let pois = pois {
//                for poi in pois {
//                    print(poi.itemID)
//                }
//            }

            
           
        }
        
        
        init(locationManager: LocationManager) {
                    self.locationManager = locationManager
                    first = true
                    auth = false
                    super.init()
                }

        
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        func handlePoiTap() {
                // 탭된 Poi에 대한 처리를 여기에 작성
                print("Poi 탭됨")
            }
        
        func addViews() {
//            var simplePoi : SimplePOI = SimplePOI(co)
          //  print("여기다 여기 여기를 봐라 \n\n\n\n \(locationManager.lon) // \(locationManager.lat)\n\n\n")

            let defaultPosition: MapPoint = MapPoint(longitude: locationManager.lon ?? 127.1, latitude: locationManager.lat ?? 37.2)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
            
            if controller?.addView(mapviewInfo) == Result.OK {
                let _ = controller?.getView("mapview") as! KakaoMap
            }
//
            createLabelLayer()
            createPoiStyle()
            createPois()
        }
        
        func containerDidResized(_ size: CGSize) {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
            if first {
       //         print("여기다 여기 여기를 봐라 여기 카메라 업데이트가 있다\n\n\n\n \(locationManager.lon) // \(locationManager.lat)\n\n\n")

                let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: locationManager.lon ?? 126.978365, 
                                                                                    latitude: locationManager.lat ?? 37.566691),
                                                                                    zoomLevel: 16, mapView: mapView!)
                mapView?.moveCamera(cameraUpdate)
                
                first = false
            }
            

        }
        
        func authenticationSucceeded() {
            auth = true
        }
        
       
    }
}

