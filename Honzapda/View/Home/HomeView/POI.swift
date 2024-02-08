import Foundation
import KakaoMapsSDK


// poi값을 받아온다




struct poiData{
    
    let mapPoint : MapPoint
    let Added : Bool
}
var mapPoints: [MapPoint] = []

func createMapPoints(from document : Document){
    if let long = Double(document.x), let lati = Double(document.y) {
            let newMapPoint = MapPoint(longitude: long, latitude: lati)
            mapPoints.append(newMapPoint)
        }
    else {
        print("poi 생성실패")
    }
}

