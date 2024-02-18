import Foundation

struct SavedCafeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [SavedCafeResult]
}

struct SavedCafeResult: Codable, Identifiable {
    let shopId: Int
    let shopName: String
    let description: String
    let shopPhoneNumber: String
    let mainImage: String
    let reviewCount: Int?
    let rating: Double
    let address: String
    let address_spec: String
    let stationDistance: String
    let openNow: Bool
    let userLike: Bool
    let inactiveDate: String
    let userHelpInfoDtoList: [String]?
    let reviewList: [String]?
    let businessHours: [BusinessHours]
    let latitude: String?
    let longitude: String?
    let averageCongestions: String?
    let dayCongestions: String?
    let totalSeatCount: Int
    let cameraCount: Int
    let wifiCount: Int
    var id: Int {
           return shopId
       }
}

struct BusinessHours: Codable {
    let dayOfWeek: String
    let openHours: String?
    let closeHours: String?
    let isOpen: Bool
}
