import Foundation
import KakaoMapsSDK


// poi값을 받아온다




struct poiData{
    
    let mapPoint : MapPoint
    let Added : Bool
}
var mapPoints: [MapPoint] = []

func createMapPointsKakao(from document : KakaoCafe){
    if let long = Double(document.x), let lati = Double(document.y) {
            let newMapPoint = MapPoint(longitude: long, latitude: lati)
            mapPoints.append(newMapPoint)
        
        //print ( "poi 생성됨")
        }
    else {
        print("poi 생성실패")
    }
}

func createMapPointsHonzapda(from document : HonzapdaCafe){
    let long = document.x!
    let lati = document.y!
    let newMapPoint = MapPoint(longitude: long, latitude: lati)
    mapPoints.append(newMapPoint)
   
}
