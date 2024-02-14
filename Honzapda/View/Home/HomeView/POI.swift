import Foundation
import KakaoMapsSDK


// poi값을 받아온다




struct poiData : Identifiable{
    
    let mapPoint : MapPoint
    let id : String
    
    
}
var mapPoints: [MapPoint] = []
var poiArr : [poiData] = []
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
    print(document.id as Any)
    print(document.placeName as Any)
//    let poi_id = document.id
   let newMapPoint = MapPoint(longitude: long, latitude: lati)
//    let newPoidata = poiData(mapPoint: newMapPoint, id: poi_id!)
//    poiArr.append(newPoidata)

    mapPoints.append(newMapPoint)
   
}
