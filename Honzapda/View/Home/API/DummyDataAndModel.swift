import Foundation

let lat : String = "37.5204279064529"
let lon : String = "126.887847771379"

struct IntegratedCafe : Identifiable { // 필요할 시 이니셜라이저 사용
    let id  = UUID() //기본세팅
    var dataFrom : String? = "kakao/honzapda" //필수
    var dataFromId : Int = 999999//필수
    var placeName: String? = "가게이름"  // hon - placeName  km - place_name
    var address: String? = "00시 00구 000길 00-0"    //
    var cafeImage: String? = ""  // photoURL
    var phoneCall: String? = "010-1111-2222" // phone phone
    var discription: String? = "카페에 대한 설명을 부탁드려요!"  // discription
    var posFromStation: String? = "역에서부터 거리 정보가 없어요" // none
    var rating: String? = "0" // rating
    var reviewCount: String? = "0"
    var x : String?
    var y : String?
    var densityOfDays: [Int]? = [1,1,1,1,1,1,1] //1 : 여유 2: 중간 3: 혼잡
}



struct HonzapdaCafe: Codable, Identifiable {
    let id: Int?
    let placeName: String?
    let adminName: String?
    let description: String?
    let otherDetails: String?
    let shopPhoneNumber: String?
    let adminPhoneNumber: String?
    let address: String?
    let addressSpec: String?
    let inactiveDate: String?
    let openNow: Bool?
    let photoUrl: String?
    let rating: Double?
    let reviewCount: Int?
    let x: Double?
    let y: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case placeName = "place_name"
        case adminName
        case description
        case otherDetails = "otherDetails"
        case shopPhoneNumber = "phone"
        case adminPhoneNumber
        case address
        case addressSpec = "address_spec"
        case inactiveDate
        case openNow
        case photoUrl
        case rating
        case reviewCount
        case x
        case y
    }
}


struct KakaoCafe: Codable, Identifiable {
    // let id = UUID()
    let address_name: String
    let category_group_code: String
    let category_group_name: String
    let category_name: String
    let distance: String
    let id: String
    let phone: String?
    let place_name: String
    let place_url: String
    let road_address_name: String
    let x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case address_name
        case category_group_code
        case category_group_name
        case category_name
        case distance
        case id
        case phone
        case place_name
        case place_url
        case road_address_name
        case x
        case y
    }
}






//struct Document: Codable, Identifiable {
//    // let id = UUID()
//    let address_name: String
//    let category_group_code: String
//    let category_group_name: String
//    let category_name: String
//    let distance: String
//    let id: String
//    let phone: String?
//    let place_name: String
//    let place_url: String
//    let road_address_name: String
//    let x: String
//    let y: String
//    
//    enum CodingKeys: String, CodingKey {
//        case address_name
//        case category_group_code
//        case category_group_name
//        case category_name
//        case distance
//        case id
//        case phone
//        case place_name
//        case place_url
//        case road_address_name
//        case x
//        case y
//    }
//    
//}
//
//var tempDataSetArr: [TabViewDataset] = [
//    TabViewDataset(
//        storeName: "Cafe Latte",
//        address: "123 Coffee Street",
//        cafeImage: "CafeSampleIMG",
//        callNumber: "123-456-7890",
//        summery: "Cozy place with delicious coffee and cakes.",
//        posFromStation: "5 minutes from the station",
//        starPoint: "4.5",
//        reviewNum: "120",
//        densityOfDays: [1, 2, 3, 2, 1, 3, 2]
//    ),
//    TabViewDataset(
//        storeName: "Green Tea House",
//        address: "456 Tea Lane",
//        cafeImage: "CafeSampleIMG",
//        callNumber: "098-765-4321",
//        summery: "Specialized in green tea and traditional desserts.",
//        posFromStation: "10 minutes from the central park",
//        starPoint: "4.0",
//        reviewNum: "95",
//        densityOfDays: [2, 3, 1, 3, 2, 1, 2]
//    ),
//    TabViewDataset(
//        storeName: "Bean's Joy",
//        address: "789 Bean's Blvd",
//        cafeImage: "CafeSampleIMG",
//        callNumber: "555-123-4567",
//        summery: "A modern cafe with a selection of bean-to-cup coffee.",
//        posFromStation: "2 minutes from the library",
//        starPoint: "4.8",
//        reviewNum: "230",
//        densityOfDays: [3, 2, 1, 2, 3, 2, 1]
//    ),
//    TabViewDataset(
//        storeName: "Bakery & Coffee",
//        address: "101 Bake Rd",
//        cafeImage: "CafeSampleIMG",
//        callNumber: "222-333-4444",
//        summery: "Freshly baked goods every morning with your favorite coffee.",
//        posFromStation: "Next to the city hall",
//        starPoint: "4.7",
//        reviewNum: "150",
//        densityOfDays: [1, 3, 2, 3, 1, 2, 3]
//    ),
//    TabViewDataset(
//        storeName: "The Espresso Bar",
//        address: "202 Espresso St",
//        cafeImage: "CafeSampleIMG",
//        callNumber: "666-777-8888",
//        summery: "Espresso, latte, cappuccino, and more in a contemporary space.",
//        posFromStation: "3 minutes from the museum",
//        starPoint: "4.3",
//        reviewNum: "180",
//        densityOfDays: [2, 1, 3, 1, 2, 3, 2]
//    ),
//    TabViewDataset(
//        storeName: "스테이 어도러블",
//        address: "경기 용인시 기흥구 죽전로 43번길 15-3 1층",
//        cafeImage: "CafeSampleIMG",
//        callNumber: "010-777-8888",
//        summery: "인테리어가 귀엽고 강아지가 감성적이에요",
//        posFromStation: "3 minutes from the museum",
//        starPoint: "4.63",
//        reviewNum: "363",
//        densityOfDays: [2, 1, 3, 1, 2, 3, 2]
//    )
//]
