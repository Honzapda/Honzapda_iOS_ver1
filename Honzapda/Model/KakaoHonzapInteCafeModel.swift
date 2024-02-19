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
    let posFromStation : String?
    let densityOfDays : [Int]?
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
        case posFromStation
        case densityOfDays
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



